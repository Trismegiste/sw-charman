<atout>
    <form class="pure-form pure-g">
        <legend class="pure-u-1">{ opts.title || 'Atouts' }</legend>
        <div class="pure-u-1">
            <select name="atout" class="pure-input-1" onchange="{ onAppendAtout }">
                <option value="0">Cliquez pour ajouter...</option>
                <optgroup each="{ race in filter }" label="{race}">
                    <option each="{ atoutList[race] }" value="{titre}" if="{ enabled=='1' }">{titre}</option>
                </optgroup>
            </select>
        </div>
        <virtual each="{ model.current.atout[group] }">
            <div class="pure-u-1-{ info == '1' ? '2' : '1' }">
                <label>
                    <input type='radio' name="selectedEdge"
                              checked="{checkedAtout == this}" onclick="{ onCheckedEdge }"/>
                    {titre}
                </label>
            </div>
            <div class="pure-u-1-2" if="{ info == '1' }">
                <input name="atoutInfo" value="{detail}"
                       class="pure-input-1" onchange="{ parent.onUpdateDetail }"/>
            </div>
        </virtual>
        <div class="pure-u-1-3">
            <button class="pure-button" onclick="{ onMoveUp }"><i class="icon-up-open"></i></button>
            <button class="pure-button" onclick="{ onMoveDown }"><i class="icon-down-open"></i></button>
        </div>
        <div class="pure-u-1-3">
            <button class="pure-button button-error" onclick="{ onDelete }"><i class="icon-trash-empty"></i></button>
        </div>
        <div class="pure-u-1-3"><label class="centered">XP { model.current.getXP(group) }</label></div>
    </form>
    <style>
        atout button {
            margin-top: 0.6em;
        }
    </style>
    <script>
        this.model = SwCharman.model
        this.group = opts.group || 0;
        this.checkedAtout = undefined;
        this.filter = opts.filter.split(" ")
        var self = this;

        SwCharman.table.fetch('atout').then(function(data) {
            self.atoutList = data
            self.update()
        })

        onAppendAtout(e) {
            for(var race in self.atoutList) {
                var raceList = self.atoutList[race]
                for(var k = 0; k < raceList.length; k++) {
                    if (raceList[k].titre === e.target.value) {
                        var found = raceList[k]
                        var temp = self.model.clone(found)
                        self.model.current.atout[self.group].push(temp)
                        e.target.value = 0;
                    }
                }
            }
        }

        onUpdateDetail(e) {
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(e.item)
            if (-1 !== idx) {
                tab[idx].detail = e.target.value
            }
        }

        onCheckedEdge(e) {
            self.checkedAtout = e.item;
        }

        onDelete(e) {
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(self.checkedAtout)
            if (-1 !== idx) {
                tab.splice(idx, 1)
            }
        }

        onMoveUp(e) {
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(self.checkedAtout)
            if (-1 !== idx) {
                if (idx > 0) {
                    var tmp = tab[idx - 1]
                    tab[idx - 1] = tab[idx]
                    tab[idx] = tmp;
                }
            }
        }

        onMoveDown(e) {
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(self.checkedAtout)
            if (-1 !== idx) {
                if (idx < (tab.length - 1)) {
                    var tmp = tab[idx + 1]
                    tab[idx + 1] = tab[idx]
                    tab[idx] = tmp
                }
            }
        }

        this.model.on('update-hindrance', function() {
            self.update()
        })

    </script>
</atout>