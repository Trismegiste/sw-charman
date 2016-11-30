/*
 * A repository class for all SW data
 */
SwTable = function (rootDir) {
    this.rootDir = rootDir
    this.data = {}
}

SwTable.prototype.fetch = function (filename) {
    var self = this

    return new Promise(function (resolve, reject) {
        if (!self.data.hasOwnProperty(filename)) {
            fetch(self.rootDir + filename + '.json')
                    .then(function (response) {
                        return response.json()
                    })
                    .then(function (data) {
                        self.data[filename] = data
                        resolve(data)
                    })
        } else {
            resolve(self.data[filename])
        }
    })
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
