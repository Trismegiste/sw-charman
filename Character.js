/*
 * Character object
 */

var Character = function () {
    this.name = '';
    this.currentWounds = 0;
    this.spentToken = 0;
    this.currentFatigue = 0;
    this.property = {};
    this.fighting = 0;
    this.vigor = 4;

    this.getMaxToken = function () {
        return 3 + (this.property['Chanceux'] ? 1 : 0)
                + (this.property['Très Chanceux'] ? 1 : 0)
                + (this.property['Malchanceux'] ? -1 : 0)
                + (this.property['Gamin'] ? 1 : 0);
    };

    this.getParry = function () {
        return 2 + Math.floor(this.fighting / 2);
    };

    this.getToughness = function () {
        return 2 + Math.floor(this.vigor / 2);
    };

    this.rangedToBeHit = function () {
        return 4;
    };
};
