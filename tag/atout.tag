<atout>
    <form class="pure-form pure-g">
        <legend class="pure-u-1">{ opts.title || 'Atouts' }</legend>
        <div class="pure-u-1">
            <select name="atout" class="pure-input-1" onchange="{ onAppendAtout }">
                <option></option>
                <option each="{ atoutList }" value="{titre}">{titre}</option>
            </select>
        </div>
        <virtual each="{ model.current.atout[group] }">
            <div class="pure-u-1-2">
                <label>{titre}</label>
            </div>
            <div class="pure-u-1-2">
                <input if="{ info == '1' }" name="atoutInfo" value="{detail}"
                       class="pure-input-1" onchange="{ parent.onUpdateDetail }"/>
            </div>
        </virtual>
        <div class="pure-u-1-2"></div>
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
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(e.item)
            if (-1 !== idx) {
                tab[idx].detail = e.target.value
            }
        }

    </script>
</atout>