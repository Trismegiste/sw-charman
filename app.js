/*
 * Main app
 */

var app = {
    init: function () {
        var pc1 = new Character();
        pc1.name = 'Arkel';
        pc1.fighting = 8;
        app.addCharacter(pc1);

        var pc2 = new Character();
        pc2.name = 'Dracka';
        pc2.fighting = 12;
        app.addCharacter(pc2);

        // event
        $('#pc-list').on('change', function (e) {
            riot.route('char/' + $('#pc-list').val());
        });

    },
    addCharacter: function (pc) {
        $('#pc-list').append('<option>' + pc.name + '</option>');
        this.model.push(pc);
    },
    model: []
};