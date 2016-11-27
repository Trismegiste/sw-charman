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
        ]
    }
}
