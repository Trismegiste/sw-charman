/*
 * Model for this SPA
 */

var Model = function () {
    riot.observable(this);
    this.characterList = [];
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
    this.kaList = ['soleil','lune-noire','orichalque']
    for (var k = 0; k < 5; k++) {
        this.kaList.push(this.equilibrePentacle[k].dominant)
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

        return []
    },
    getOppose: function (dominant) {
        for (var k = 0; k < 5; k++) {
            if (this.equilibrePentacle[k].dominant === dominant) {
                return this.equilibrePentacle[k].oppose
            }
        }

        return []
    }
}