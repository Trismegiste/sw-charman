var NephilimRendering = function (charac) {
    if (charac.type !== 'nephilim') {
        throw 'Bad type of ' + charac.name
    }
    this.character = charac;
}

NephilimRendering.prototype = {
    getDocument: function () {
        return {
            content: [
                {
                    table: {
                        headerRows: 0,
                        widths: ['33%', '33%', '33%'],
                        body: [
                            [this.getIdentite(), {colSpan: 2, text: this.getHistoire(), fontSize: 10}, {}],
                            ['Value 1', 'Value 2', 'Value 3'],
                            [{text: 'Bold value', bold: true}, 'Val 2', 'Val 3']
                        ]
                    }
                }
            ]
        };
    },
    getIdentite: function () {
        return [
            'Nom: ' + this.character.name,
            'Initiation: ' + this.getDiceText(this.character.pentacle.initiation),
            'Ka dominant: ' + this.character.pentacle.dominant,
            'Neutre fav: ' + this.character.pentacle.neutreFav,
            'Opposé maj: ' + this.character.pentacle.opposeMaj
        ]
    },
    getDiceText: function (val) {
        var choice = [];
        for (var k = 4; k < 12; k++) {
            choice[k] = 'd' + k
        }
        choice[13] = 'd12+1'
        choice[14] = 'd12+2'

        return choice[val]
    },
    getHistoire: function () {
        var periode = [
            "Les Guerres Elémentaires",
            "Les Compacts Secrets",
            "L’ Hermétisme",
            "Les Guerres Secrètes",
            "Les Nouveaux Mondes",
            "La Révélation"
        ]
        var view = [];
        for (var k in periode) {
            var titre = periode[k];
            view.push(titre + ': ' + this.character.incarnation[titre].Titre)
        }
        return view.join("\n")
    }
}