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
                <option each="{ka in model.kaList}" value="{ka}">{ ka }</option>
            </select>
        </div>
        <div class="pure-u-1-4">
            <label>INI</label>
        </div>
        <div class="pure-u-1-4">
            <select name="initiation" class="pure-input-1" data-is="dice-option"
                    value="{ model.current.uniqueKa.initiation || opts.value }"></select>
        </div>
    </form>
    <script>
        this.model = SwCharman.model
        var self = this

        onChangeKa() {
            self.model.current.uniqueKa = {
                ka: self.uniqueKa.value,
                initiation: self.initiation.value
            }
        }
    </script>
</unique-ka>