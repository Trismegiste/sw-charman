/*
 * A repository class for all SW data
 */
SwTable = function (rootDir) {
    this.rootDir = rootDir
    this.data = {}
    this.promise = {}
}

SwTable.prototype.fetch = function (filename) {
    var self = this
    if (!this.promise.hasOwnProperty(filename)) {

        this.promise[filename] = fetch(this.rootDir + filename + '.json')
                .then(function (response) {
                    return response.json()
                })
                .then(function (data) {
                    self.data[filename] = data
                })
    }

    return this.promise[filename]
}

SwTable.prototype.atoutFindByName = function (name) {
    for (var k in this.atout) {
        var atout = atout[k]
        if (atout.titre === name) {
            return atout
        }
    }

    return null
}
