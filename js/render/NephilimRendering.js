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
                            [
                                this.getCompetences(0),
                                [
                                    this.getAtoutCreation(0),
                                    this.getHandicap(0),
                                    this.getAspect()
                                ],
                                this.getAtout(0)
                            ]
                        ]
                    },
                    layout: 'noBorders'
                },
                {
                    table: {
                        widths: ['33%', '33%', '33%'],
                        body: [
                            [this.getAttribut(), this.getHandicap(1), this.getAtoutCreation(1)],
                            [
                                this.getCompetences(1),
                                this.getAtout(1),
                                {text: 'toto'}
                            ]
                        ]
                    },
                    layout: 'noBorders'
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
                headerRows: 1,
                widths: ['75%', '25%'],
                body: [[{text: 'Compétences', colSpan: 2}, {}]]
            },
            layout: 'lightHorizontalLines',
            margin: [0, 5]
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
                headerRows: 1,
                widths: ['100%'],
                body: [['Atouts de création']]
            },
            layout: 'lightHorizontalLines',
            margin: [0, 5]
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
                headerRows: 1,
                widths: ['10%', '90%'],
                body: [[{text: 'Progressions', colSpan: 2}, {}]]
            },
            layout: 'lightHorizontalLines',
            margin: [0, 5]
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
                headerRows: 1,
                widths: ['85%', '15%'],
                body: [[{text: 'Handicaps', colSpan: 2}, {}]]
            },
            layout: 'lightHorizontalLines',
            margin: [0, 5]
        }

        for (var k in this.character.handicap[group]) {
            var item = this.character.handicap[group][k]
            listing.table.body.push([item.titre, item.value.substr(0, 3)])
        }

        return listing
    },
    getAspect: function () {
        var meta = this.character.metamorphe;
        var rm = Math.floor(this.character.pentacle.initiation / 2) + 2
        var asp = 12 - rm

        var listing = {
            table: {
                headerRows: 1,
                widths: ['70%', '30%'],
                body: [
                    [{text: 'Métamorphe', colSpan: 2}, {}],
                    [meta.nom, meta.humeur],
                    ['Aspect', asp.toString()],
                    ['Résist. magique', rm.toString()]
                ]
            },
            layout: 'lightHorizontalLines',
            margin: [0, 5]
        }

        return listing
    },
    getAttribut: function () {
        var ka = this.character.uniqueKa;
        var listing = {
            table: {
                headerRows: 1,
                widths: ['75%', '25%'],
                body: [
                    [{text: 'Attributs', colSpan: 2}, {}],
                    ['Ka-' + ka.ka, this.getDiceText(ka.initiation)],
                ]
            },
            layout: 'lightHorizontalLines',
            margin: [0, 5]
        }
        for (var key in this.character.attribute) {
            var attr = this.character.attribute[key]
            listing.table.body.push([key, this.getDiceText(attr)])
        }

        return listing
    }
}