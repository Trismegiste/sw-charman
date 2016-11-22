<atout>
    <form class="pure-form pure-g">
        <legend class="pure-u-1">{ opts.title || 'Atouts' }</legend>
        <div class="pure-u-1">
            <select name="atout" class="pure-input-1" onchange="{ onAppendAtout }">
                <option></option>
                <option each="{ atoutList }" value="{titre}">{titre}</option>
            </select>
        </div>
        <virtual each="{ atout, idx in model.current.atout[group] }">
            <div class="pure-u-1-{ atout.info == '1' ? '2' : '1' }">
                <label><input type='radio' name="selectedEdge" value="{idx}">{atout.titre}</label>
            </div>
            <div class="pure-u-1-2" if="{ atout.info == '1' }">
                <input name="atoutInfo" value="{atout.detail}"
                       class="pure-input-1" onchange="{ parent.onUpdateDetail }"/>
            </div>
        </virtual>
        <div class="pure-u-1-2">
            <button class="pure-button" onclick="{ onMoveUp }">&uparrow;</button>
            <button class="pure-button" onclick="{ onDelete }">&times;</button>
            <button class="pure-button" onclick="{ onMoveDown }">&downarrow;</button>
        </div>
        <div class="pure-u-1-4"><label class="centered">XP</label></div>
        <div class="pure-u-1-4"><label class="centered">{ model.current.getXP(group) }</label></div>
    </form>
    <script>
        this.mixin('model')
        this.group = opts.group || 0;
        var self = this;

        fetch('./data/atout.json')
                .then(function(response){
                    return response.json()
                })
                .then(function(data){
                    self.atoutList = data['humain']
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
            console.log()
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(e.item.atout)
            if (-1 !== idx) {
                tab[idx].detail = e.target.value
            }
        }

        onDelete(e) {
            var tab = self.model.current.atout[self.group];
            self.selectedEdge.forEach(function (radio) {
                if (radio.checked) {
                    tab.splice(radio.value, 1)
                }
            })
        }

    </script>
</atout>