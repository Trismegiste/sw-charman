<attribut>
    <form class="pure-form pure-g form-label-aligned">
        <legend class="pure-u-1">Attributs</legend>
        <virtual each="{ attr in attributList }">
            <div class="pure-u-1-4"><label>{attr}</label></div>
            <div class="pure-u-1-4">
                <select name="{attr}" class="pure-input-1" data-is="dice-option"></select>
            </div>
        </virtual>
    </form>
    <script>
        this.attributList = [
            'AGI', 'FOR', 'VIG', 'INT', 'ÂME'
        ]
    </script>
</attribut>