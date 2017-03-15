<cloud-backup class="webcomponent pure-g">
    <div class="pure-u-1 pure-u-md-1-2 pure-u-xl-1-3">
        <form class="pure-form form-label-aligned" onsubmit="{
                    onBackup
                }">
            <div class="pure-g">
                <div class="pure-u-1-4"><label>Nom</label></div>
                <div class="pure-u-3-4"><input class="pure-input-1" type="text"
                                               name="filename" value="{backupName}"
                                               placeholder="A filename to backup to"
                                               required="true"/>
                </div>
                <div class="pure-u-1-4"><label>Folder</label></div>
                <div class="pure-u-3-4"><input class="pure-input-1" type="text"
                                               name="folder" required="true" readonly="true"
                                               value="{driveFolder.name}"
                                               placeholder="Click to pick a folder"
                                               onclick="{
                                                           onFolderPicking
                                                       }"/>
                </div>
                <div class="pure-u-1-4"></div>
                <div class="pure-u-3-4">
                    <button class="pure-button button-error" if="{driveFolder.id}">
                        Backup to Google Drive
                    </button>
                </div>
            </div>
        </form>
    </div>
    <script>
        var self = this
        this.driveFolder = {}
        this.backupName = 'Character Manager'
        this.mixin('toasty')

        onFolderPicking() {
            cloudClient.pickOneFolder()
                    .then(function (choice) {
                        self.driveFolder = choice
                        self.update()
                    })
        }

        // upload to google
        onBackup() {
            repository.findAll().then(function(arr) {
                var temp = [];
                arr.forEach(function(item, idx) {
                    temp.push(item);
                })

                cloudClient.saveFile(self.filename.value, 'application/json', JSON.stringify(temp), self.driveFolder.id)
                        .then(function(rsp) {
                            self.notice(arr.length + ' items saved', 'success')
                        })
            })
        }
    </script>
</cloud-backup>