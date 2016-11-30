<competence>
    <form class="pure-form pure-g">
        <legend class="pure-u-1">{ opts.title || 'Compétences' }</legend>
        <div class="pure-u-1">
            <select name="competence" class="pure-input-1" onchange="{ onAppendCompetence }">
                <option value="0">Cliquez pour ajouter...</option>
                <option each="{ comp in competenceList }" value="{comp.title}">{comp.title}</option>
            </select>
        </div>
        <virtual each="{ model.current.competence[group] }">
            <div class="pure-u-1-2">
                <label if="{ !editable }">{title}</label>
                <input if="{ editable }" name="competenceName" value="{title}"
                       class="pure-input-1" onchange="{ parent.onUpdateTitle }"/>
            </div>
            <div class="pure-u-1-4">
                <label class="centered">{attr}</label>
            </div>
            <div class="pure-u-1-4">
                <select name="competenceValue" class="pure-input-1"
                        data-is="dice-option" value="{ value }"
                        onchange="{ parent.onUpdateValue }"></select>
            </div>
        </virtual>
        <div class="pure-u-1-2"></div>
        <div class="pure-u-1-4"><label class="centered">Pts.</label></div>
        <div class="pure-u-1-4"><label class="centered">{ model.current.getCompetencePoint(group) }</label></div>
    </form>
    <script>
        this.model = SwCharman.model
        this.group = opts.group || 0;
        this.competenceList = SwCharman.table.get('competence')
        var self = this;


        onAppendCompetence(e) {
            for(var k = 0; k < self.competenceList.length; k++) {
                if (self.competenceList[k].title === e.target.value) {
                    var found = self.competenceList[k]
                    var temp = self.model.clone(found)
                    temp.value = 4;
                    self.model.current.competence[self.group].push(temp)
                    e.target.value = 0;
                }
            }
        }

        onUpdateValue(e) {
            var tab = self.model.current.competence[self.group];
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

        onUpdateTitle(e) {
            var tab = self.model.current.competence[self.group];
            var idx = tab.indexOf(e.item)
            if (-1 !== idx) {
                tab[idx].title = e.target.value
            }
        }

    </script>
</competence>