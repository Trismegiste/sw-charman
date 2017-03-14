<cloud-import class="webcomponent pure-g">
    <div class="pure-u-1 pure-u-md-1-2 pure-u-xl-1-3">
        <form class="pure-form form-label-aligned" onsubmit="{
                    onImport
                }">
            <div class="pure-g">
                <div class="pure-u-1-4"><label>Backup file</label></div>
                <div class="pure-u-3-4"><input class="pure-input-1" type="text"
                                               name="filename" required="true" readonly="true"
                                               value="{backup.name}"
                                               placeholder="Click to pick a file"
                                               onclick="{
                                                           onFilePicking
                                                       }"/>
                </div>
                <div class="pure-u-1-4"></div>
                <div class="pure-u-3-4">
                    <button class="pure-button button-primary" if="{backup.id}">
                        Import from Google Drive
                    </button>
                </div>
            </div>
        </form>
    </div>
    <script>
        var self = this
        this.backup = {}
        this.mixin('toasty')

        onFilePicking() {
            cloudClient.pickOneFile('application/json')
                    .then(function (choice) {
                        self.backup = choice
                        self.update()
                    })
        }

        // upload to google
        onImport() {
            gapi.client.drive.files.get({
                        fileId: self.backup.id,
                        alt: 'media'
                    }).then(function(rsp) {
                        var insert = []
                        rsp.result.forEach(function(obj) {
                            insert.push(repository.persist(obj))
                        })
                        Promise.all(insert).then(function (rsp) {
                            self.notice(rsp.length + ' items imported', 'success')
                        }).catch(function(rsp) {
                            console.log(rsp)
                            self.notice('Import has failed','error')
                        })
                    })
        }
    </script>
</cloud-import>