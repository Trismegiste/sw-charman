/*
 * A repository class for all SW data
 */
SwTable = function (rootDir) {
    this.rootDir = rootDir
}

SwTable.prototype.atoutFindAll = function () {
    var self = this
    if (!this.hasOwnProperty('atout')) {
        fetch(this.rootDir + 'atout.json').then(function (response) {
            return response.json()
        }).then(function (data) {
            self.atout = data
        })
    }

    return this.atout;
}

SwTable.prototype.atoutFindByName = function (name) {
    var tab = this.atoutFindAll();
    for (var k in tab) {
        var atout = tab[k]
        if (atout.titre === name) {
            return atout
        }
    }

    return null
}
