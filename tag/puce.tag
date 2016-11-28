<puce>
    <div class="pure-g">
        <input type="hidden" name="{ opts.name }" value="{ barre }"/>
        <div class="pure-u-1-4" each="{ idx in [1, 2, 3, 4] }">
            <label>
                <input type="checkbox" value="{ idx }" checked="{ idx <= barre }" onclick="{
                            parent.onClick
                        }"/>
            </label>
        </div>
    </div>

    <script>
        this.barre = opts.value
        var self = this

        onClick(e) {
            self.barre = e.target.checked ? e.item.idx : e.item.idx - 1;
        }
    </script>
</puce>