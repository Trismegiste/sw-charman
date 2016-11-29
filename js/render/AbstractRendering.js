var AbstractRendering = function (charac) {
    this.character = charac;
}

AbstractRendering.prototype.getDocument = function () {
    throw 'Abstract class'
}

AbstractRendering.prototype.getDiceText = function (val) {
    var choice = [];
    for (var k = 4; k <= 12; k += 2) {
        choice[k] = 'd' + k
    }
    choice[13] = 'd12+1'
    choice[14] = 'd12+2'

    return choice[val]
}

AbstractRendering.prototype.getCompetences = function (group) {
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
}

AbstractRendering.prototype.getAtoutCreation = function (group) {
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
        console.log(k)
        var atout = atoutCreation[k]
        var titre = atout.titre
        if (atout.hasOwnProperty('detail')) {
            titre += ' ' + atout.detail
        }
        listing.table.body.push([titre])
    }

    return listing
}

AbstractRendering.prototype.getAtout = function (group) {
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
}

AbstractRendering.prototype.getHandicap = function (group) {
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
}

AbstractRendering.prototype.getAttribut = function () {
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

AbstractRendering.prototype.getPuce = function (nb) {
    var tab = []
    for (var k = 1; k <= 4; k++) {
        var idx = (k <= nb) ? 1 : 0
        tab.push({
            image: SwCharman.assetManager.get('puce-' + idx),
            fit: [10, 10]
        })
    }

    return {
        table: {
            body: [tab]
        },
        layout: 'noBorders'
    }
}