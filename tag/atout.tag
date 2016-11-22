<atout>
    <form class="pure-form pure-g">
        <legend class="pure-u-1">{ opts.title || 'Atouts' }</legend>
        <div class="pure-u-1">
            <select name="atout" class="pure-input-1" onchange="{ onAppendAtout }">
                <option></option>
                <option each="{ atoutList }" value="{titre}" if="{ enabled=='1' }">{titre}</option>
            </select>
        </div>
        <virtual each="{ model.current.atout[group] }">
            <div class="pure-u-1-{ info == '1' ? '2' : '1' }">
                <label>
                    <input type='radio' name="selectedEdge"
                              checked="{checkedAtout == this}" onclick="{ onCheckedEdge }">
                    {titre}
                </label>
            </div>
            <div class="pure-u-1-2" if="{ info == '1' }">
                <input name="atoutInfo" value="{detail}"
                       class="pure-input-1" onchange="{ parent.onUpdateDetail }"/>
            </div>
        </virtual>
        <div class="pure-u-1-3">
            <button class="pure-button" onclick="{ onMoveUp }">&uparrow;</button>
            <button class="pure-button" onclick="{ onMoveDown }">&downarrow;</button>
        </div>
        <div class="pure-u-1-3">
            <button class="pure-button button-error" onclick="{ onDelete }">&times;</button>
        </div>
        <div class="pure-u-1-3"><label class="centered">XP { model.current.getXP(group) }</label></div>
    </form>
    <script>
        this.mixin('model')
        this.group = opts.group || 0;
        this.checkedAtout = undefined;
        var self = this;

        fetch('./data/atout.json')
                .then(function(response){
                    return response.json()
                })
                .then(function(data){
                    self.atoutList = data[opts.filter]
                })

        onAppendAtout(e) {
            for(var k = 0; k < self.atoutList.length; k++) {
                if (self.atoutList[k].titre === e.target.value) {
                    var found = self.atoutList[k]
                    var temp = self.model.clone(found)
                    self.model.current.atout[self.group].push(temp)
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