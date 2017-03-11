/*
 * Google drive wrapper
 */

var GoogleDrive = function () {
    riot.observable(this);

    this.boundary = '-------314159265358979323846264';
    this.delimiter = "\r\n--" + this.boundary + "\r\n";
    this.close_delim = "\r\n--" + this.boundary + "--";
    this.DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"];
    this.SCOPES = 'https://www.googleapis.com/auth/drive';
    this.clientId = null
}

GoogleDrive.prototype.connect = function (id) {
    this.clientId = id
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