<attribut>
    <form class="pure-form pure-g form-label-aligned" onchange="{
                onChange
            }">
        <legend class="pure-u-1">Attributs</legend>
        <virtual each="{ attr in attributList }">
            <div class="pure-u-1-4"><label>{attr}</label></div>
            <div class="pure-u-1-4">
                <select name="{attr}" class="pure-input-1" data-is="dice-option"></select>
            </div>
        </virtual>
        <div class="pure-u-1-4"><label>Pts.</label></div>
        <div class="pure-u-1-4"><label class="centered">{ compteur }</label></div>
    </form>
    <script>
        this.mixin('model')
        this.attributList = [
            'AGI', 'FOR', 'VIG', 'INT', 'ÂME'
        ]
        this.compteur = 0;
        var self = this;

        onChange() {
            var obj = self.model.current.attribute;
            self.attributList.forEach(function(key) {
                obj[key] = self[key].value
            })
            self.compteur = self.model.current.getAttributePoint()
        }
    </script>
</attribut>