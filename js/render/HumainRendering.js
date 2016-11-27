var HumainRendering = function (charac) {
    if (charac.type !== 'humain') {
        throw 'Bad type of ' + charac.name
    }
    AbstractRendering.call(this, charac)
}

HumainRendering.prototype = Object.create(AbstractRendering.prototype)
HumainRendering.prototype.constructor = HumainRendering

HumainRendering.prototype.getDocument = function () {
    return {
        content: [
            {
                table: {
                    widths: ['33%', '33%', '33%'],
                    body: [
                        [
                            this.getAttribut(),
                            [this.getHandicap(0), this.getAtoutCreation(0)],
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
        ]
    }
}
