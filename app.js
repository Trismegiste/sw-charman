/*
 * Main app
 */

var app = {
    init: function () {
        var pc = new Character();
        pc.name = 'Arkel';
        pc.property["Chanceux"] = true;
        pc.property["Très Chanceux"] = true;
        pc.property["Gamin"] = true;
        app.addCharacter(pc);
        // event
        $('#pc-list').on('change', function (e) {
            app.model.forEach(function (item) {
                var search = $('#pc-list').val();
                if (item.name === search) {
                    $('#pc-view').html(JSON.stringify(item, null, 2));
                }
            });
        });

    },
    addCharacter: function (pc) {
        $('#pc-list').append('<option>' + pc.name + '</option>');
        this.model.push(pc);
    },
    model: []
};