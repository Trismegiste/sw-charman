<content-database>
    <table class="pure-table pure-table-striped checkable-listing" style="width: 100%">
        <tr each="{ listing }">
            <td>
                <a href="#" onclick="{
                            parent.onAppend
                        }">{name}</a>
                <i class="icon-{ type }"></i>
                <i if="{wildCard}" class="icon-wildcard"></i>
            </td>
        </tr>
    </table>
    <google-drive-doc></google-drive-doc>
    <script>
        this.mixin('toasty')
        this.model = SwCharman.model
        var self = this

        self.listing = [];

        this.onAppend = function (event) {
            // looped item
            var item = event.item
            for (var idx in self.listing) {
                var pc = self.listing[idx]
                if (item.name === pc.name) {
                    var obj = Object.assign(new Character, pc)
                    self.model.characterList.push(obj);
                    self.notice(pc.name + ' ajouté', 'primary')
                }
            }
        }

        this.model.on('update-db', function (rows) {
            self.listing = rows
            self.update()
        })
    </script>
</content-database>
