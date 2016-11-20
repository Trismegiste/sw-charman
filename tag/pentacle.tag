<pentacle>
    <form class="pure-form">
        <legend>Pentacle</legend>
        <div>
            Ka dominant
            <select name="dominant" value="{ model.pentacle.dominant }" onchange="{ onChangeDominant }">
                <option each="{ka in equilibrePentacle}" value="{ka.dominant}">{ ka.dominant }</option>
            </select>
        </div>
        <div>
            Neutre favorable
            <virtual each="{ka, idx in getNeutre(model.pentacle.dominant)}">
                <input type="radio" name="neutre" value="{ka}"
                       checked="{ model.pentacle.neutreFav == ka }"/>{ka}
            </virtual>
        </div>
        <div>
            Opposé majeur
            <virtual each="{ka, idx in getOppose(model.pentacle.dominant)}">
                <input type="radio" name="oppose" value="{ka}"
                       checked="{ model.pentacle.opposeMaj == ka }"/>{ka}
            </virtual>
        </div>
    </form>
    <script>
        this.equilibrePentacle = [
            {dominant: 'feu', neutre: ['air', 'terre'], oppose: ['eau', 'lune']},
            {dominant: 'lune', neutre: ['eau', 'terre'], oppose: ['air', 'feu']},
            {dominant: 'air', neutre: ['feu', 'eau'], oppose: ['terre', 'lune']},
            {dominant: 'terre', neutre: ['feu', 'lune'], oppose: ['eau', 'air']},
            {dominant: 'eau', neutre: ['lune', 'air'], oppose: ['terre', 'feu']}
        ]

        this.model = {pentacle: {dominant: 'feu', neutreFav: 'terre', opposeMaj: 'lune'}}
        this.currentNeutre = [];
        var self = this;

        getNeutre(dominant) {
            for (var k = 0; k < 5; k++) {
                if (self.equilibrePentacle[k].dominant == dominant) {
                    return self.equilibrePentacle[k].neutre
                }
            }

            return []
        }

        getOppose(dominant) {
            for (var k = 0; k < 5; k++) {
                if (self.equilibrePentacle[k].dominant == dominant) {
                    return self.equilibrePentacle[k].oppose
                }
            }

            return []
        }

        onChangeDominant(e) {
            // @todo reset radio
            self.model.pentacle.dominant = self.dominant.value;
        }

    </script>
</pentacle>
