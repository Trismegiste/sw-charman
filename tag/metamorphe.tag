<metamorphe>
    <form class="pure-form pure-g form-label-aligned" onchange="{
                onChange
            }">
        <legend class="pure-u-1">Métamorphe</legend>
        <div class="pure-u-1">
            <select name="metamorphe" class="pure-input-1" value="{ model.current.metamorphe.nom }">
                <option>Choix d'un métamorphe...</option>
                <option each="{ meta, idx in metamorpheList }" value="{ meta.nom }"
                        if="{ (meta.element == model.current.pentacle.dominant) }">
                    {meta.nom} ({meta.humeur})
                </option>
            </select>
        </div>
    </form>
    <script>
        this.model = SwCharman.model
        this.metamorpheList = []
        var self = this;

        fetch('./data/metamorphe.json')
                .then(function (response) {
                    return response.json()
                })
                .then(function (data) {
                    self.metamorpheList = data
                })

        this.model.on('update-pentacle', function (ka) {
            self.update()
        })

        onChange() {
            var value = self.metamorphe.value;
            for(var k in self.metamorpheList) {
                var meta = self.metamorpheList[k];
                if (value === meta.nom) {
                    self.model.current.metamorphe = meta
                }
            }
        }
    </script>
</metamorphe>