/*
 * Model for this SPA
 */

var Model = function () {
    riot.observable(this);
    this.characterList = [];
    this.current = new Character();
    var self = this;

    this.on('reset', function () {
        self.current = new Character()
    })
}


