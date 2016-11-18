/*
 * Character object
 */

var Character = function () {
    this.name = '';
    this.currentWounds = 0;
    this.spentToken = 0;
    this.currentFatigue = 0;
    this.property = {};
    this.attack = 0;
    this.damage = '';
    this.toughness = 4;
    this.target = '';
    this.shaken = false;
    this.toHit = 2;
};

Character.prototype = {
    getMaxToken: function () {
        return 3 + (this.property['Chanceux'] ? 1 : 0)
                + (this.property['Très Chanceux'] ? 1 : 0)
                + (this.property['Malchanceux'] ? -1 : 0)
                + (this.property['Gamin'] ? 1 : 0);
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
    }
};

