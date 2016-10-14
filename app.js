/*
 * Main app
 */

var app = {
    init: function () {
        var pc = new Character();
        pc.property["Chanceux"] = true;
        pc.property["Très Chanceux"] = true;
        pc.property["Gamin"] = true;
        app.model.push(pc);
    },
    model: []
};