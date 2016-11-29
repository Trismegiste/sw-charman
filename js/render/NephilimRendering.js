var NephilimRendering = function (charac) {
    if (charac.type !== 'nephilim') {
        throw 'Bad type of ' + charac.name
    }
    AbstractRendering.call(this, charac)

    this.prefix = {
        'feu': 'pyr',
        'eau': 'hydr',
        'terre': 'faë',
        'Lune': 'onir',
        'air': 'eol'
    }
}

NephilimRendering.prototype = Object.create(AbstractRendering.prototype)
NephilimRendering.prototype.constructor = NephilimRendering

NephilimRendering.prototype.getDocument = function () {
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
                        [
                            this.getAttribut(),
                            [this.getHandicap(1), this.getAtoutCreation(1)],
                            this.getCompetences(1)
                        ],
                        [
                            this.getAtout(1),
                            {text: ''},
                            {text: ''}
                        ]
                    ]
                },
                layout: 'noBorders'
            }
        ]
    }
}

NephilimRendering.prototype.getIdentite = function () {
    var title = this.getTitle()
    title = title.charAt(0).toUpperCase() + title.slice(1)
            + ' '
            + this.character.name.charAt(0).toUpperCase() + this.character.name.slice(1)
    return [
        title,
        'Initiation: ' + this.getDiceText(this.character.pentacle.initiation),
        'Ka dominant: ' + this.character.pentacle.dominant,
        'Neutre fav: ' + this.character.pentacle.neutreFav,
        'Opposé maj: ' + this.character.pentacle.opposeMaj
    ]
}

NephilimRendering.prototype.getHistoire = function () {
    var view = [];
    for (var key in this.character.incarnation) {
        var periode = this.character.incarnation[key];
        view.push(periode['Période'] + ': ' + periode.Titre)
    }
    return view.join("\n")
}

NephilimRendering.prototype.getAspect = function () {
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
}

NephilimRendering.prototype.getTitle = function () {
    return this.prefix[this.character.pentacle.dominant] + 'im'
}
