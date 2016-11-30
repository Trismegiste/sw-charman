/*
 * A repository class for all SW data
 */
SwTable = function (rootDir) {
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