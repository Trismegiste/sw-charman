var NephilimRendering = function (charac) {
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
                            ['Nom: ' + this.character.name, 'Second', 'Third'],
                            ['Value 1', 'Value 2', 'Value 3'],
                            [{text: 'Bold value', bold: true}, 'Val 2', 'Val 3']
                        ]
                    }
                }
            ]
        };
    }
}