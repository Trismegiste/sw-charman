<unique-ka>
    <form class="pure-form pure-g form-label-aligned" onchange="{
                onChangeKa
            }">
        <legend class="pure-u-1">{ opts.title || 'Ka'}</legend>
        <div class="pure-u-1-2">
            <select name="uniqueKa" class="pure-input-1"
                    value="{ model.current.uniqueKa.ka || opts.ka }"
                    disabled="{ opts.disabled }" >
                <option></option>
                <option each="{ka in kaList}" value="{ka}">{ ka }</option>
            </select>
        </div>
        <div class="pure-u-1-4">
            <label>INI</label>
        </div>
        <div class="pure-u-1-4">
            <select name="initiation" class="pure-input-1" data-is="dice-option"
                    value="{ model.current.uniqueKa.initiation || opts.value }"></select>
        </div>
        <div class="pure-u-1-2">
            <label>
                <input type="checkbox" name="linked"/>
                Lié attributs
            </label>
        </div>
        <div class="pure-u-1-2">
            <div class="pure-g">
                <div class="pure-u-1-4" each="{ idx in [1, 2, 3, 4] }">
                    <label>
                        <input type="checkbox" value="{ idx }" checked="{ idx <= model.current.uniqueKa.puce }" onclick="{
                            parent.onClickPuce
                        }"/>
                    </label>
                </div>
            </div>
        </div>
    </form>
    <script>
        this.model = SwCharman.model
        this.kaList = (opts.mode == 5) ? this.model.kaPentacle : this.model.kaList
        var self = this

        onChangeKa() {
            var obj = self.model.current.uniqueKa
            obj.ka = self.uniqueKa.value
            obj.initiation = self.initiation.value
            if (self.linked.checked) {
                self.model.trigger('init-attributs', obj.initiation)
            }
        }

        onClickPuce(e) {
            var obj = self.model.current.uniqueKa
            obj.puce = e.target.checked ? e.item.idx : e.item.idx - 1;
        }
    </script>
</unique-ka>