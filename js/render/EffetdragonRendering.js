var EffetdragonRendering = function (charac) {
    if (charac.type !== 'effetdragon') {
        throw 'Bad type of ' + charac.name
    }
    EtreKaRendering.call(this, charac)
}

EffetdragonRendering.prototype = Object.create(EtreKaRendering.prototype)
EffetdragonRendering.prototype.constructor = EffetdragonRendering
