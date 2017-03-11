/*
 * Google drive wrapper
 */

var GoogleDrive = function (param) {
    riot.observable(this);

    this.boundary = '-------314159265358979323846264';
    this.delimiter = "\r\n--" + this.boundary + "\r\n";
    this.close_delim = "\r\n--" + this.boundary + "--";
    this.DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"];
    this.SCOPES = 'https://www.googleapis.com/auth/drive';
    this.clientId = param.clientId
    this.appId = param.appId
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
                }
            })
        })
    })

}

GoogleDrive.prototype.pickOneFolder = function () {
    return new Promise(function (fulfill, reject) {

        var docsView = new google.picker.DocsView()
                .setIncludeFolders(true)
                .setMimeTypes('application/vnd.google-apps.folder')
                .setSelectFolderEnabled(true)

        var picker = new google.picker.PickerBuilder()
                .enableFeature(google.picker.Feature.NAV_HIDDEN)
                .setAppId(this.appId)
                .setOAuthToken(gapi.auth2.getAuthInstance().currentUser.get().getAuthResponse().access_token)
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