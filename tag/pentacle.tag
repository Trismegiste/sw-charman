<pentacle>
    <form class="pure-form pure-g form-label-aligned">
        <legend class="pure-u-1">Pentacle</legend>
        <div class="pure-u-1-4">
            <label>Ka dom.</label>
        </div>
        <div class="pure-u-1-4">
            <select name="dominant" class="pure-input-1" value="{ model.pentacle.dominant }" onchange="{
                        onChangeDominant
                    }">
                <option each="{ka in model.equilibrePentacle}" value="{ka.dominant}">{ ka.dominant }</option>
            </select>
        </div>
        <div class="pure-u-1-4">
            <label>INI</label>
        </div>
        <div class="pure-u-1-4">
            <select name="initiation" class="pure-input-1" data-is="dice-option"></select>
        </div>
        <div class="pure-u-1-4">
            <label>Neut. fav.</label>
        </div>
        <virtual each="{ka, idx in model.getNeutre(model.pentacle.dominant)}">
            <div class="pure-u-3-8">
                <label>
                    <input type="radio" name="neutre" value="{ka}"
                           checked="{ model.pentacle.neutreFav == ka }"/>{ka}
                </label>
            </div>
        </virtual>
        <div class="pure-u-1-4">
            <label>Opp. maj.</label>
        </div>
        <virtual each="{ka, idx in model.getOppose(model.pentacle.dominant)}">
            <div class="pure-u-3-8">
                <label>
                    <input type="radio" name="oppose" value="{ka}"
                           checked="{ model.pentacle.opposeMaj == ka }"/>{ka}
                </label>
            </div>
        </virtual>
    </form>
    <script>
        this.mixin('model')

        this.model.pentacle = {dominant: 'feu', neutreFav: 'terre', opposeMaj: 'lune'}
        var self = this;

        onChangeDominant(e) {
            // @todo reset radio
            self.model.pentacle.dominant = self.dominant.value;
        }

    </script>
</pentacle>
