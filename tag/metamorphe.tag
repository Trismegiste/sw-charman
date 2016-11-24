<metamorphe>
    <form class="pure-form pure-g form-label-aligned" onchange="{
                onChange
            }">
        <legend class="pure-u-1">Métamorphe</legend>
        <div class="pure-u-1">
            <select name="humeurFilter" class="pure-input-1" value="{ model.current.metamorphe.humeur }">
                <option>Humeur...</option>
                <option each="{ titre in humeurList }" value="{titre}">{titre}</option>
            </select>
        </div>
        <div class="pure-u-1">
            <select name="metamorphe" class="pure-input-1" value="{ model.current.metamorphe.nom }">
                <option>Cliquez pour ajouter...</option>
                <option each="{ meta, idx in metamorpheList }" value="{idx}"
                        if="{ (meta.humeur == currentHumeur) && (meta.element == model.current.pentacle.dominant) }">
                    {meta.nom}
                </option>
            </select>
        </div>
    </form>
    <script>
        this.model = SwCharman.model
        this.metamorpheList = []
        this.humeurList = []
        this.currentHumeur = undefined
        var self = this;

        fetch('./data/metamorphe.json')
                .then(function (response) {
                    return response.json()
                })
                .then(function (data) {
                    self.metamorpheList = data
                })

        this.model.on('update-pentacle', function (ka) {
            self.humeurList = []
            for (var k in self.metamorpheList) {
                var meta = self.metamorpheList[k]
                if ((ka === meta.element) && (-1 === self.humeurList.indexOf(meta.humeur))) {
                    self.humeurList.push(meta.humeur)
                }
            }
            console.log(self.humeurList)
            self.update()
        })

        onChange() {
            self.currentHumeur = self.humeurFilter.value
            self.model.current.metamorphe = self.metamorpheList[self.metamorphe.value]
        }
    </script>
</metamorphe>