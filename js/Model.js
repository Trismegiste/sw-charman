/*
 * Model for this SPA
 */

var Model = function () {
    riot.observable(this);
    this.characterList = [];  // Array of Character
    this.cloudList = [];  // Array of POJO
    this.current = new Character();
    var self = this;

    // data pentacle
    this.equilibrePentacle = [
        {dominant: 'feu', neutre: ['air', 'terre'], oppose: ['eau', 'lune']},
        {dominant: 'lune', neutre: ['eau', 'terre'], oppose: ['air', 'feu']},
        {dominant: 'air', neutre: ['feu', 'eau'], oppose: ['terre', 'lune']},
        {dominant: 'terre', neutre: ['feu', 'lune'], oppose: ['eau', 'air']},
        {dominant: 'eau', neutre: ['lune', 'air'], oppose: ['terre', 'feu']}
    ]
    // data 8 ka
    this.kaList = ['soleil', 'lune-noire', 'orichalque']
    this.kaPentacle = []
    for (var k = 0; k < 5; k++) {
        this.kaList.push(this.equilibrePentacle[k].dominant)
        this.kaPentacle.push(this.equilibrePentacle[k].dominant)
    }

    // event
    this.on('reset', function () {
        self.current = new Character()
    })
}

Model.prototype = {
    getNeutre: function (dominant) {
        for (var k = 0; k < 5; k++) {
            if (this.equilibrePentacle[k].dominant === dominant) {
                return this.equilibrePentacle[k].neutre
            }
        }

        return ['', '']
    },
    getOppose: function (dominant) {
        for (var k = 0; k < 5; k++) {
            if (this.equilibrePentacle[k].dominant === dominant) {
                return this.equilibrePentacle[k].oppose
            }
        }

        return ['', '']
    },
    clone: function (obj) {
        // Handle the 3 simple types, and null or undefined
        if (null == obj || "object" != typeof obj)
            return obj;

        // Handle Date
        if (obj instanceof Date) {
            var copy = new Date();
            copy.setTime(obj.getTime());
            return copy;
        }

        // Handle Array
        if (obj instanceof Array) {
            var copy = [];
            for (var i = 0, len = obj.length; i < len; i++) {
                copy[i] = this.clone(obj[i]);
            }
            return copy;
        }

        // Handle Object
        if (obj instanceof Object) {
            var copy = Object.create(obj);
            for (var attr in obj) {
                if (obj.hasOwnProperty(attr))
                    copy[attr] = this.clone(obj[attr]);
            }
            return copy;
        }

        throw new Error("Unable to copy obj! Its type isn't supported.");
    },
    getEquilibreFor: function (ka) {
        for (var idx in this.equilibrePentacle) {
            var eq = this.equilibrePentacle[idx]
            if (eq.dominant === ka) {
                return eq
            }
        }
        throw new Error(ka + ' is not one of the five Ka')
    },
    findByName: function (name) {
        var pc
        for (var idx in this.cloudList) {
            pc = this.cloudList[idx]
            if (pc.name === name) {
                return pc
            }
        }

        return null
    },
    stackNew: function (json) {
        var obj = Object.assign(new Character, json)
        this.characterList.push(obj);
    }
}