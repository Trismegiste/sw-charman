<competence>
    <form class="pure-form pure-g" onchange="{
                onChange
            }">
        <legend class="pure-u-1">Compétences</legend>
        <div class="pure-u-1">
            <select name="competence" class="pure-input-1" onchange="{ onAppendCompetence }">
                <option></option>
                <option each="{ comp in competenceList }" value="{comp.title}">{comp.title}</option>
            </select>
        </div>
        <virtual each="{ model.competence }">
            <div class="pure-u-1-2">
                <label if="{ !editable }">{title}</label>
                <input if="{ editable }" name="competenceName" value="{title}" class="pure-input-1"/>
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
        <div class="pure-u-1-4"><label class="centered">{ compteur }</label></div>
    </form>
    <script>
        this.competenceList = [
            {title: 'Combat', attr: 'AGI', editable: false},
            {title: 'Connaissance', attr: 'INT', editable: true}
        ]
        this.compteur = 0;
        this.model = {
            competence: [
                {title: 'Tir', attr: 'AGI', editable: false, value: 8}
            ]
        };
        var self = this;

        onAppendCompetence(e) {
            for(var k = 0; k < self.competenceList.length; k++) {
                if (self.competenceList[k].title === e.target.value) {
                    var found = self.competenceList[k]
                    var temp = Object.assign(Object.create(found), found);
                    temp.value = 4;
                    self.model.competence.push(temp)
                }
            }
        }

        onUpdateValue(e) {
            // delete if empty value
            if (e.target.value == 0) {
                var idx = self.model.competence.indexOf(e.item);
                if (idx !== -1) {
                    self.model.competence.splice(idx, 1)
                }
            }
        }

        onChange() {
            self.compteur = 0
        }
    </script>
</competence>