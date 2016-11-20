<unique-ka>
    <form class="pure-form pure-g form-label-aligned">
        <legend class="pure-u-1">Ka</legend>
        <div class="pure-u-1-2">
            <select name="uniqueKa" class="pure-input-1" value="{ model.uniqueKa }" onchange="{
                        onChangeKa
                    }">
                <option each="{ka in model.kaList}" value="{ka}">{ ka }</option>
            </select>
        </div>
        <div class="pure-u-1-4">
            <label>INI</label>
        </div>
        <div class="pure-u-1-4">
            <select name="initiation" class="pure-input-1" data-is="dice-option" value="{ model.initiation }"></select>
        </div>
    </form>
    <script>
        this.mixin('model')
        this.model.uniqueKa = 'feu'
        this.model.initiation = '8';
    </script>
</unique-ka>