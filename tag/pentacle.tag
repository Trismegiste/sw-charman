<pentacle>
    <form class="pure-form pure-g">
        <legend class="pure-u-1">Pentacle</legend>
        <div class="pure-u-1-3">
            <label>Ka dom.</label>
        </div>
        <div class="pure-u-2-3">
            <select name="dominant" class="pure-input-1" value="{ model.pentacle.dominant }" onchange="{ onChangeDominant }">
                <option each="{ka in equilibrePentacle}" value="{ka.dominant}">{ ka.dominant }</option>
            </select>
        </div>
        <div class="pure-u-1-3">
            <label>Neutre fav.</label>
        </div>
        <virtual each="{ka, idx in getNeutre(model.pentacle.dominant)}">
            <div class="pure-u-1-3">
                <label>
                    <input type="radio" name="neutre" value="{ka}"
                           checked="{ model.pentacle.neutreFav == ka }"/>{ka}
                </label>
            </div>
        </virtual>
        <div class="pure-u-1-3">
            <label>Opposé maj.</label>
        </div>
        <virtual each="{ka, idx in getOppose(model.pentacle.dominant)}">
            <div class="pure-u-1-3">
                <label>
                    <input type="radio" name="oppose" value="{ka}"
                           checked="{ model.pentacle.opposeMaj == ka }"/>{ka}
                </label>
            </div>
        </virtual>
    </form>
    <script>
        this.mixin('model')
        this.equilibrePentacle = this.model.equilibrePentacle

        this.model = {pentacle: {dominant: 'feu', neutreFav: 'terre', opposeMaj: 'lune'}}
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
