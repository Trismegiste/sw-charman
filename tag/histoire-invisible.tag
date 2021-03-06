<histoire-invisible>
    <form class="pure-form pure-g" onchange="{ onChange }">
        <legend class="pure-u-1">Périodes d'incarnation</legend>
        <div each="{ libelle in periode }" class="pure-u-1">
            <label>{libelle}</label>
            <select name="incarnation" class="pure-input-1" value="{ model.current.incarnation[libelle].Titre }">
                <option></option>
                <option each="{ ev in evenement[libelle] }" value="{ ev.Titre }">{ ev.Titre }</option>
            </select>
        </div>
        <div class="pure-u-1-4 small-footnotes" each="{ name, val in model.current.getCoeffArcaneMineur() }">
            { name } : {val}
        </div>
    </form>
    <script>
        this.model = SwCharman.model
        this.periode = []
        this.evenement = {}
        var self = this;

        (function (data) {
            for (var idx in data) {
                var ev = data[idx]
                if (-1 === self.periode.indexOf(ev['Période'])) {
                    self.periode.push(ev['Période'])  // to keep the sorting
                }
            }
            for (var idx in data) {
                var ev = data[idx]
                if (!self.evenement.hasOwnProperty(ev['Période'])) {
                    self.evenement[ev['Période']] = [];
                }
                self.evenement[ev['Période']].push(ev)
            }
        })(SwCharman.table.get('histoire'))

        onChange() {
            self.model.current.incarnation = {}
            for (var idx in self.incarnation) {
                var selectWidget = self.incarnation[idx]
                var periodeLibelle = self.periode[idx]
                // search the event in this periodeLibelle with the Titre equals to selectWidget.value
                for(var k in self.evenement[periodeLibelle]) {
                    var ev = self.evenement[periodeLibelle][k];
                    if (ev.Titre === selectWidget.value) {
                        self.model.current.incarnation[periodeLibelle] = ev
                    }
                }
            }
        }
    </script>
</histoire-invisible>