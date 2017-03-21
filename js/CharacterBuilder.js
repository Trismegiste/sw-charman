/*
 * Template for Character
 */
var CharacterBuilder = function (data) {
    this.atoutList = data
    var self = this
    this.typeList = {
        nephilim: {title: 'Nephilim', build: function (c) {
                c.type = 'nephilim'
                var a = self.findAtoutByName('Nephilim')
                c.atout[0] = [a]
            }
        },
        effetdragon: {title: 'Effet-dragon', build: function (c) {
                c.type = 'effetdragon'
                var a = self.findAtoutByName('Créature de Ka')
                c.atout[0] = [
                    self.findAtoutByName('Créature de Ka'),
                    self.findAtoutByName('Élémentaire'),
                ]
                c.atout[1] = []
            }
        },
        kabbale: {title: 'Créature de Kabbale', build: function (c) {
                c.type = 'kabbale'
                c.atout[0] = [
                    self.findAtoutByName('Créature de Ka'),
                    self.findAtoutByName('Invisibilité profane'),
                ]
                c.atout[1] = []
            }
        },
        humain: {title: 'Humain', build: function (c) {
                c.type = 'humain'
                c.atout[0] = []
                c.atout[1] = []
            }
        }
    }
}

CharacterBuilder.prototype.getTemplate = function () {
    return this.typeList
}

CharacterBuilder.prototype.build = function (templateName, charac) {
    this.typeList[templateName].build(charac)
}

CharacterBuilder.prototype.findAtoutByName = function (name) {
    for (var idx in this.atoutList) {
        var atout = this.atoutList[idx]
        if (atout.titre === name) {
            return atout
        }
    }

    throw new Error('Cannot find atout ' + name)
}
