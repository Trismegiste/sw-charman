<content-database>
    <table class="pure-table pure-table-striped checkable-listing" style="width: 100%">
        <tr each="{ model.cloudList }">
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
            var pc = self.model.findByName(event.item.name)
            if (pc) {
                self.model.characterList.push(pc)
                self.notice(pc.name + ' ajouté', 'primary')
            }
        }

        this.model.on('update-db', function (rows) {
            rows.sort(function (a, b) {
                return a.name.localeCompare(b.name)
            })

            self.model.cloudList = []
            for (var idx in rows) {
                var pc = self.model.createFrom(rows[idx])
                self.model.cloudList.push(pc)
            }
            self.update()
        })

        // persist
        this.model.on('store-db', function (temp) {
            var found = self.model.findIdxByName(temp.name)
            // insert/update
            if (found !== -1) {
                self.model.cloudList[found] = temp
            } else {
                self.model.cloudList.push(temp)
            }

            self.saveToCloud()

        })

        // delete
        this.model.on('delete-db', function (temp) {
            var found = self.model.findIdxByName(temp.name)
            // delete
            if (found !== -1) {
                self.model.cloudList.splice(found, 1)
                self.saveToCloud()
            }
        })

        this.saveToCloud = function () {
            cloudClient.saveFile(SwCharman.cloudFile.name, 'application/json', JSON.stringify(self.model.cloudList), SwCharman.cloudFolder.id)
                    .then(function (rsp) {
                        self.notice(self.model.cloudList.length + ' personnages sauvés', 'success')
                    })
        }

    </script>
</content-database>
