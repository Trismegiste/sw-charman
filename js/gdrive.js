/*
 * Google drive wrapper
 */

var GoogleDrive = function (param) {
    riot.observable(this);

    this.DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"];
    this.SCOPES = 'https://www.googleapis.com/auth/drive';
    this.clientId = param.clientId
    this.appId = param.appId
    this.maxPerPage = 256
}

GoogleDrive.prototype.connect = function () {
    var self = this

    return new Promise(function (fulfill, reject) {
        gapi.load('client:auth2:picker', function () {
            gapi.client.init({
                discoveryDocs: self.DISCOVERY_DOCS,
                clientId: self.clientId,
                scope: self.SCOPES
            }).then(function () {
                if (!gapi.auth2.getAuthInstance().isSignedIn.get()) {
                    console.log('OAuth process with popup')
                    return gapi.auth2.getAuthInstance().signIn()
                } else {
                    return new Promise(function (f, r) {
                        console.log('already logged')
                        f()
                    })
                }
            }).then(function () {
                if (gapi.auth2.getAuthInstance().isSignedIn.get()) {
                    fulfill()
                } else {
                    reject()
                }
            })
        })
    })

}

GoogleDrive.prototype.getAccessToken = function () {
    return gapi.auth2.getAuthInstance().currentUser.get().getAuthResponse().access_token
}


GoogleDrive.prototype.pickOneFolder = function () {
    var argggg = this

    return new Promise(function (fulfill, reject) {

        var docsView = new google.picker.DocsView()
                .setIncludeFolders(true)
                .setMimeTypes('application/vnd.google-apps.folder')
                .setSelectFolderEnabled(true)

        var picker = new google.picker.PickerBuilder()
                .enableFeature(google.picker.Feature.NAV_HIDDEN)
                //    .setAppId(this.appId)
                .setOAuthToken(argggg.getAccessToken())
                .addView(docsView)
                .setCallback(function (res) {
                    console.log(res)
                    if (res.action === 'picked') {
                        fulfill(res.docs[0])
                    }
                    if (res.action === 'cancel') {
                        reject(res)
                    }
                })
                .build()

        picker.setVisible(true)
    })
}

GoogleDrive.prototype.listing = function (folderId, filterOnType) {
    var query = "'" + folderId + "' in parents and trashed=false"
    if (filterOnType !== undefined) {
        query += " and mimeType='" + filterOnType + "'"
    }
    return gapi.client.drive.files.list({
        pageSize: this.maxPerPage,
        fields: "nextPageToken, files(id, name, parents, modifiedTime)",
        q: query
    })
}

GoogleDrive.prototype.saveFile = function (fileName, contentType, content, rootId) {
    var self = this
    var fileMetadata = {
        name: fileName,
        parents: [rootId]
    }

    return gapi.client.drive.files.list({
        pageSize: 1,
        fields: "files(id)",
        q: "'" + rootId
                + "' in parents and trashed=false and name='"
                + fileName + "' and mimeType='"
                + contentType + "'"
    }).then(function (rsp) {
        if (rsp.result.files.length === 1) {
            console.log(fileName + ' existed, id=' + rsp.result.files[0].id)
            return new Promise(function (f, r) {
                f({result: {id: rsp.result.files[0].id}})
            })
        } else {
            console.log('Creating ' + fileName)
            return gapi.client.drive.files.create({
                resource: fileMetadata,
                fields: 'id'
            })
        }
    }).then(function (resp) {
        console.log('Updating ' + resp.result.id)
        return self.updateContent(resp.result.id, contentType, content)
    })
}

GoogleDrive.prototype.updateContent = function (id, contentType, content) {
    return new Promise(function (fulfill, reject) {
        gapi.client.request({
            path: '/upload/drive/v3/files/' + id,
            method: 'PATCH',
            params: {
                uploadType: 'media'
            },
            headers: {'Content-Type': contentType},
            body: content
        }).then(fulfill, reject)
    })
}
