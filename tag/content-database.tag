<content-database>
    <table class="pure-table pure-table-striped checkable-listing" style="width: 100%">
        <tr each="{ listing }">
            <td>
                <input type="radio" name="radiochoice" value="{name}"/>
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

        this.on('update', function () {
            console.log('refresh')
            SwCharman.repository.findAll()
                    .then(function (arr) {
                        self.listing = [];
                        arr.forEach(function (obj) {
                            self.listing.push(obj);
                        })
                    })
        })

        this.onAppend = function (event) {
            // looped item
            var item = event.item
            SwCharman.repository.findByPk(item.name).then(function (pc) {
                console.log('found ' + pc.name);
                self.model.characterList.push(pc);
                self.notice(pc.name + ' ajouté', 'primary')
            })
        }

        this.model.on('update-db', function () {
            self.update()
        })
    </script>
</content-database>
