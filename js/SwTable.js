/*
 * A repository class for all SW data
 */
var SwTable = function (rootDir) {
    this.rootDir = rootDir
    this.listing = ['atout', 'competence', 'handicap', 'histoire', 'metamorphe']
    this.data = {}
}

SwTable.prototype.createPromise = function (filename) {
    var self = this

    return new Promise(function (fulfill, reject) {
        fetch(self.rootDir + filename + '.json').then(function (response) {
            return response.json()
        }).then(function (content) {
            fulfill([filename, content])
        })
    })
}

SwTable.prototype.load = function () {
    var self = this

    var loading = []
    for (var idx in this.listing) {
        loading.push(this.createPromise(this.listing[idx]))
    }

    return new Promise(function (fulfill, reject) {
        Promise.all(loading).then(function (loaded) {
            for (var k in loaded) {
                var result = loaded[k]
                self.data[result[0]] = result[1]
            }
            fulfill()
        })
    })
}

SwTable.prototype.get = function (key) {
    if (!this.data.hasOwnProperty(key)) {
        throw new Error(key + ' not found')
    }
    return this.data[key]
}

SwTable.prototype.getAtoutGroupList = function () {
    var result = []
    for (var idx in this.data['atout']) {
        var atout = this.data['atout'][idx]
        if ((atout.enabled == 1) && (-1 === result.indexOf(atout.group))) {
            result.push(atout.group)
        }
    }

    return result
}

SwTable.prototype.getAtoutSubGroupListFor = function (group) {
    var result = []
    for (var idx in this.data['atout']) {
        var atout = this.data['atout'][idx]
        if ((atout.enabled == 1) && (atout.group === group) && (-1 === result.indexOf(atout.subgroup))) {
            result.push(atout.subgroup)
        }
    }

    return result
}

SwTable.prototype.getAtoutListFor = function (group, subgroup) {
    var result = []
    for (var idx in this.data['atout']) {
        var atout = this.data['atout'][idx]
        if ((atout.enabled == 1) && (atout.group === group) && (atout.subgroup === subgroup)) {
            result.push(atout)
        }
    }

    return result
}