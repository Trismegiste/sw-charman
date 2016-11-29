/*
 * Character object
 */

var Character = function () {
    this.name = '';
    this.currentWounds = 0;
    this.spentToken = 0;
    this.currentFatigue = 0;
    this.attack = 0;
    this.damage = '';
    this.toughness = 4;
    this.target = '';
    this.shaken = false;
    this.toHit = 2;
    // detail
    this.type = 'virtual';
    this.attribute = {}
    this.pentacle = {}
    this.uniqueKa = {}
    this.competence = [[], []]
    this.handicap = [[], []]
    this.atout = [[], []]
    this.incarnation = {}
    this.metamorphe = {}
};

Character.prototype = {
    getMaxToken: function () {
        return 3
    },
    restart: function () {
        this.currentWounds = 0;
        this.spentToken = 0;
        this.currentFatigue = 0;
        this.target = '';
        this.shaken = false;
    },
    // this method is just an hint about how this character is lethal
    getLethality: function () {
        return Math.floor(0.2 * (this.attack / 2 * ((this.toughness - 3) / 2 + (this.toHit - 2))))
    },
    getAttributePoint: function () {
        var sum = 0
        var self = this
        Object.keys(this.attribute).forEach(function (key) {
            sum += (self.attribute[key] - 4) / 2
        })

        return sum;
    },
    getCompetencePoint: function (group) {
        var sum = 0
        for (var k = 0; k < this.competence[group].length; k++) {
            sum += (this.competence[group][k].value - 2) / 2
        }

        return sum;
    },
    getXP: function (group) {
        var nb = this.atout[group].length - this.getHindrancePoint(group) / 2 - 1

        return 5 * (nb + (nb > 16 ? nb - 16 : 0))
    },
    getHindrancePoint: function (group) {
        var sum = 0
        var tab = this.handicap[group]
        for (var h in tab) {
            sum += (tab[h].value == 'Mineur') ? 1 : 2
        }

        return sum;
    },
    getCoeffArcaneMineur: function () {
        var arcane = {"Mystères": 0, "R+C": 0, "Synarchie": 0, "Temple": 0}
        for (var idx in this.incarnation) {
            var ev = this.incarnation[idx]
            for (var am in arcane) {
                if (ev.hasOwnProperty(am)) {
                    arcane[am] += parseInt(ev[am]);
                }
            }
        }

        return arcane;
    },
    getAtoutCreation: function (group) {
        var tab = []
        var nbHandi = Math.ceil(this.getHindrancePoint(group) / 2)
        for (var k = 0; k < (nbHandi + 1); k++) {
            tab.push(this.atout[group][k])
        }

        return tab
    }
};

