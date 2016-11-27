var HumainRendering = function (charac) {
    if (charac.type !== 'humain') {
        throw 'Bad type of ' + charac.name
    }
    AbstractRendering.call(this, charac)
}

HumainRendering.prototype = Object.create(AbstractRendering.prototype)
HumainRendering.prototype.constructor = HumainRendering

HumainRendering.prototype.getDocument = function () {
    console.log(this.character)
    return {
        content: [
            {
                table: {
                    widths: ['33%', '33%', '33%'],
                    body: [
                        [
                            this.getAttribut(),
                            [this.getHandicap(O), this.getAtoutCreation(O)],
                            this.getCompetences(O)
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
