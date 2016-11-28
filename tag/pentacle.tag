<pentacle>
    <form class="pure-form pure-g form-label-aligned" onchange="{
                onChange
            }">
        <legend class="pure-u-1">Pentacle</legend>
        <div class="pure-u-1-4">
            <label>Ka dom.</label>
        </div>
        <div class="pure-u-1-4">
            <select name="dominant" class="pure-input-1" value="{ model.current.pentacle.dominant }">
                <option></option>
                <option each="{ka in model.equilibrePentacle}" value="{ka.dominant}">{ ka.dominant }</option>
            </select>
        </div>
        <div class="pure-u-1-4">
            <label>INI</label>
        </div>
        <div class="pure-u-1-4">
            <select name="initiation" class="pure-input-1"
                    data-is="dice-option" value="{ model.current.pentacle.initiation }"></select>
        </div>
        <div class="pure-u-1-2"></div>
        <div class="pure-u-1-2">
            <div class="pure-g">
                <div class="pure-u-1-4" each="{ idx in [1, 2, 3, 4] }">
                    <label>
                        <input type="checkbox" value="{ idx }" checked="{ idx <= model.current.pentacle.puce }" onclick="{
                            parent.onClickPuce
                        }"/>
                    </label>
                </div>
            </div>
        </div>
        <div class="pure-u-1-4">
            <label>Neut. fav.</label>
        </div>
        <virtual each="{ka, idx in model.getNeutre(model.current.pentacle.dominant)}">
            <div class="pure-u-3-8">
                <label>
                    <input type="radio" name="neutre" value="{ka}"
                           checked="{ model.current.pentacle.neutreFav == ka }"/>
                    {ka}
                </label>
            </div>
        </virtual>
        <div class="pure-u-1-4">
            <label>Opp. maj.</label>
        </div>
        <virtual each="{ka, idx in model.getOppose(model.current.pentacle.dominant)}">
            <div class="pure-u-3-8">
                <label>
                    <input type="radio" name="oppose" value="{ka}"
                           checked="{ model.current.pentacle.opposeMaj == ka }"/>
                    {ka}
                </label>
            </div>
        </virtual>
    </form>
    <script>
        this.model = SwCharman.model
        var self = this;

        onChange() {
            var obj = self.model.current.pentacle

            obj.dominant = self.dominant.value
            obj.initiation = self.initiation.value
            obj.neutreFav = ''
            obj.opposeMaj = ''

            // manage neutre fav
            self.neutre.forEach(function (radio) {
                if (radio.checked) {
                    self.model.current.pentacle.neutreFav = radio.value
                }
            })
            // manage opp maj
            self.oppose.forEach(function (radio) {
                if (radio.checked) {
                    self.model.current.pentacle.opposeMaj = radio.value
                }
            })
        }

        onClickPuce(e) {
            var obj = self.model.current.pentacle
            obj.puce = e.target.checked ? e.item.idx : e.item.idx - 1;
        }

        this.on('update', function() {
            if (self.dominant.value) {
                self.model.trigger('update-pentacle', self.dominant.value)
            }
        })
    </script>
</pentacle>
