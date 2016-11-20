/*
 * Model for this SPA
 */

var Model = function () {
    riot.observable(this);
    this.characterList = [];
    this.current = new Character();
    var self = this;

    this.equilibrePentacle = [
        {dominant: 'feu', neutre: ['air', 'terre'], oppose: ['eau', 'lune']},
        {dominant: 'lune', neutre: ['eau', 'terre'], oppose: ['air', 'feu']},
        {dominant: 'air', neutre: ['feu', 'eau'], oppose: ['terre', 'lune']},
        {dominant: 'terre', neutre: ['feu', 'lune'], oppose: ['eau', 'air']},
        {dominant: 'eau', neutre: ['lune', 'air'], oppose: ['terre', 'feu']}
    ]

    this.on('reset', function () {
        self.current = new Character()
    })
}


