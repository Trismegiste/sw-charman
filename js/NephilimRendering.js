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
                        widths: ['33%', '33%', '33%'],
                        body: [
                            [this.getIdentite(), {colSpan: 2, text: this.getHistoire(), fontSize: 10}, {}],
                            ['Compétences', 'Atouts création', 'Atouts'],
                            [this.getCompetences(0), this.getAtoutCreation(0), this.getAtout(0)],
                            ['wesh', 'Chutes', 'wesh'],
                            ['wesh', this.getHandicap(0), 'wesh']
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
        for (var k = 4; k <= 12; k += 2) {
            choice[k] = 'd' + k
        }
        choice[13] = 'd12+1'
        choice[14] = 'd12+2'

        return choice[val]
    },
    getHistoire: function () {
        var view = [];
        for (var key in this.character.incarnation) {
            var periode = this.character.incarnation[key];
            view.push(periode['Période'] + ': ' + periode.Titre)
        }
        return view.join("\n")
    },
    getCompetences: function (group) {
        var listing = {
            table: {
                widths: ['75%', '25%'],
                body: []
            },
            layout: 'noBorders'
        }

        for (var k in this.character.competence[group]) {
            var comp = this.character.competence[group][k]
            listing.table.body.push([comp.title, this.getDiceText(comp.value)])
        }

        return listing
    },
    getAtoutCreation: function (group) {
        var listing = {
            table: {
                widths: ['100%'],
                body: []
            },
            layout: 'noBorders'
        }
        var atoutCreation = this.character.getAtoutCreation(group);
        for (var k = 0; k < atoutCreation.length; k++) {
            var atout = atoutCreation[k]
            var titre = atout.titre
            if (atout.hasOwnProperty('detail')) {
                titre += ' ' + atout.detail
            }
            listing.table.body.push([titre])
        }

        return listing
    },
    getAtout: function (group) {
        var listing = {
            table: {
                widths: ['10%', '90%'],
                body: []
            },
            layout: 'noBorders'
        }

        var offset = this.character.getAtoutCreation(group).length;
        for (var k = offset; k < this.character.atout[group].length; k++) {
            var atout = this.character.atout[group][k]
            var titre = atout.titre
            if (atout.hasOwnProperty('detail')) {
                titre += ' ' + atout.detail
            }
            var nb = k - offset + 1;
            var cost = 5 * (nb + (nb > 16 ? nb - 16 : 0))
            listing.table.body.push([cost.toString(), titre])
        }

        return listing
    },
    getHandicap: function (group) {
        var listing = {
            table: {
                widths: ['85%', '15%'],
                body: []
            },
            layout: 'noBorders'
        }

        for (var k in this.character.handicap[group]) {
            var item = this.character.handicap[group][k]
            listing.table.body.push([item.titre, item.value.substr(0, 3)])
        }

        return listing
    }
}