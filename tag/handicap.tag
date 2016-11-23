<handicap>
    <form class="pure-form pure-g" onchange="{onChange}">
        <legend class="pure-u-1">{ opts.title || 'Handicaps' }</legend>
        <div class="pure-u-1">
            <select name="handicap" class="pure-input-1" onchange="{ onAppendHandicap }">
                <option value="0">Cliquez pour ajouter...</option>
                <option each="{ handicapList }" value="{titre}">{titre}</option>
            </select>
        </div>
        <virtual each="{ model.current.handicap[group] }">
            <div class="pure-u-3-4">
                <label>{titre}</label>
            </div>
            <div class="pure-u-1-4">
                <select name="niveauValue" class="pure-input-1" value="{ value }"
                        onchange="{ parent.onUpdateValue }">
                    <option></option>
                    <option value="Mineur" if="{ niveau != 'Majeur' }">Mineur</option>
                    <option value="Majeur" if="{ niveau != 'Mineur' }">Majeur</option>
                </select>
            </div>
        </virtual>
    </form>
    <script>
        this.mixin('model')
        this.group = opts.group || 0;
        var self = this;

        fetch('./data/handicap.json')
                .then(function(response){
                    return response.json()
                })
                .then(function(data){
                    self.handicapList = data[opts.filter]
                })

        onAppendHandicap(e) {
            for(var k = 0; k < self.handicapList.length; k++) {
                if (self.handicapList[k].titre === e.target.value) {
                    var found = self.handicapList[k]
                    var temp = self.model.clone(found)
                    temp.value = (temp.niveau == 'Majeur') ? 'Majeur' : 'Mineur';
                    self.model.current.handicap[self.group].push(temp)
                    e.target.value = 0;
                }
            }
        }

        onUpdateValue(e) {
            var tab = self.model.current.handicap[self.group];
            // delete if empty value
            if (e.target.value == 0) {
                var idx = tab.indexOf(e.item);
                if (idx !== -1) {
                    tab.splice(idx, 1)
                }
            } else {
                var idx = tab.indexOf(e.item)
                if (-1 !== idx) {
                    tab[idx].value = e.target.value
                }
            }
        }

        onChange() {
            self.model.trigger('update-hindrance')
        }

    </script>
</handicap>