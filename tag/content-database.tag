<content-database>
    <table class="pure-table pure-table-striped checkable-listing" style="width: 100%">
        <tr each="{ model.listing }">
            <td>
                <i class="icon-{ type }"></i>
                <a href="#" onclick="{
                            parent.onAppend
                        }">{name}</a>
                <i if="{wildCard}" class="icon-wildcard"></i>
            </td>
        </tr>
    </table>
    <div class="button-spacing">
        <google-drive-doc></google-drive-doc>
    </div>
    <script>
        this.mixin('toasty')
        this.model = SwCharman.model
        var self = this

        this.onAppend = function (event) {
            // looped item
            var item = event.item
            for (var idx in self.model.listing) {
                var pc = self.model.listing[idx]
                if (item.name === pc.name) {
                    var obj = Object.assign(new Character, pc)
                    self.model.characterList.push(obj);
                    self.notice(pc.name + ' ajouté', 'primary')
                }
            }
        }

        this.model.on('update-db', function (rows) {
            rows.sort(function (a, b) {
                return a.name.localeCompare(b.name)
            })

            self.model.listing = rows
            self.update()
        })

        // persist
        this.model.on('store-db', function (temp) {
            var found = -1
            for (var idx in self.model.listing) {
                var pc = self.model.listing[idx]
                if (pc.name === temp.name) {
                    found = idx
                }
            }
            // insert/update
            if (found !== -1) {
                self.model.listing[found] = temp
            } else {
                self.model.listing.push(temp)
            }

            cloudClient.saveFile(SwCharman.cloudFile.name, 'application/json', JSON.stringify(self.model.listing), SwCharman.cloudFolder.id)
                    .then(function (rsp) {
                        self.notice(self.model.listing.length + ' personnages sauvés', 'success')
                    })
        })

        // delete
        this.model.on('delete-db', function (temp) {
            var found = -1
            for (var idx in self.model.listing) {
                var pc = self.model.listing[idx]
                if (pc.name === temp.name) {
                    found = idx
                }
            }
            // insert/update
            if (found !== -1) {
                self.model.listing.splice(found, 1)

                cloudClient.saveFile(SwCharman.cloudFile.name, 'application/json', JSON.stringify(self.model.listing), SwCharman.cloudFolder.id)
                        .then(function (rsp) {
                            self.notice(self.model.listing.length + ' personnages sauvés', 'error')
                        })
            }
        })

    </script>
</content-database>
