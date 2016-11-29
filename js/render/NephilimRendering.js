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
                        [
                            {colSpan: 2, stack: [
                                    this.getIdentite(),
                                    {ul: this.getHistoire(), fontSize: 10}
                                ]
                            },
                            {},
                            this.getPentacle()
                        ],
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
        ],
        styles: {
            verticalAlign: {
                margin: [0, 6, 0, 0]
            }
        }
    }
}

NephilimRendering.prototype.getIdentite = function () {
    var title = this.getTitle()
    title = title.charAt(0).toUpperCase() + title.slice(1)
            + ' '
            + this.character.name.charAt(0).toUpperCase() + this.character.name.slice(1)
    return title
}

NephilimRendering.prototype.getHistoire = function () {
    var view = [];
    for (var key in this.character.incarnation) {
        var periode = this.character.incarnation[key];
        view.push(periode['Période'] + ': ' + periode.Titre)
    }
    return view
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

NephilimRendering.prototype.getPentacle = function () {
    return {
        table: {
            body: [
                [
                    '',
                    {
                        image: SwCharman.assetManager.get('feu'),
                        fit: [30, 30]
                    },
                    {text: 'd10', alignment: 'left', style: 'verticalAlign'},
                    ''
                ],
                [
                    {text: "+1", alignment: 'right', style: 'verticalAlign'},
                    {
                        image: SwCharman.assetManager.get('air'),
                        fit: [30, 30]
                    },
                    {
                        image: SwCharman.assetManager.get('terre'),
                        fit: [30, 30]
                    },
                    {text: "+2", alignment: 'left', style: 'verticalAlign'}
                ],
                [
                    {text: "+3", alignment: 'right', style: 'verticalAlign'},
                    {
                        image: SwCharman.assetManager.get('eau'),
                        fit: [30, 30]
                    },
                    {
                        image: SwCharman.assetManager.get('lune'),
                        fit: [30, 30]
                    },
                    {text: "+4", alignment: 'left', style: 'verticalAlign'}
                ]
            ]
        },
        layout: 'noBorders'
    }
}
