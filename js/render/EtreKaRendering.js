var EtreKaRendering = function (charac) {
    AbstractRendering.call(this, charac)
}

EtreKaRendering.prototype = Object.create(AbstractRendering.prototype)
EtreKaRendering.prototype.constructor = EtreKaRendering

EtreKaRendering.prototype.getDocument = function () {
    return {
        content: [
            {
                table: {
                    widths: ['33%', '33%', '33%'],
                    body: [
                        [
                            this.getIdentite(),
                            {},
                            this.getMonoKa()
                        ],
                        [
                            this.getAttribut(),
                            this.getAtoutCreation(0),
                            this.getCompetences(0)
                        ],
                        [
                            this.getAtout(0),
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

EtreKaRendering.prototype.getIdentite = function () {
    var title = this.getTitle()
    console.log(title)
    title = title.charAt(0).toUpperCase() + title.slice(1)
            + ' '
            + this.character.name.charAt(0).toUpperCase() + this.character.name.slice(1)
    return {text: title, margin: [0, 0, 0, 6], fontSize: 16, colSpan: 2}
}

EtreKaRendering.prototype.getMonoKa = function () {
    var essence = this.character.uniqueKa
    var tablePuce = this.getPuce(essence.puce)
    tablePuce.margin = [6, 6, 0, 0]

    return {
        table: {
            body: [
                [
                    {
                        image: SwCharman.assetManager.get(essence.ka),
                        fit: [30, 30]
                    },
                    {text: this.getDiceText(essence.initiation), alignment: 'left', style: 'verticalAlign'},
                    tablePuce
                ]
            ]
        },
        layout: 'noBorders'
    }
}