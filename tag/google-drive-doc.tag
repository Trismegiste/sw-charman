<google-drive-doc>
    <div if="{ !isAuthenticated() }" class="connexion">
        <a class="pure-button" onclick="{
                    onConnect
                }">Connexion</a>
    </div>
    <form if="{ isAuthenticated() }" class="pure-form form-label-aligned" onsubmit="{
                onBackup
            }">
        <h2>Document ({RpgImpro.document.vertex.length} vertex)</h2>
        <div class="pure-g">
            <div class="pure-u-1-4"></div>
            <div class="pure-u-3-4">
                <button class="pure-button button-primary pure-input-1" onclick="{
                            onFilePicking
                        }">Load</button>
            </div>
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
                <button class="pure-button button-error pure-input-1" if="{driveFolder.id}">
                    Save
                </button>
            </div>
        </div>
    </form>

    <script>
        var self = this
        this.driveFolder = {}
        this.backupName = 'Sans-Titre'
        this.message = ''
        this.mixin('toasty')

        this.onConnect = function () {
            cloudClient.connect()
                    .then(function () {
                        if (cloudClient.isTokenExpired()) {
                            cloudClient.refreshToken().then(function () {
                                self.update()
                            })
                        }
                        self.update()
                    })
        }

        this.on('mount', function () {
            self.onConnect()
        })

        this.isAuthenticated = function () {
            return cloudClient.isSignedIn() && !cloudClient.isTokenExpired()
        }

        this.onFolderPicking = function () {
            cloudClient.pickOneFolder()
                    .then(function (choice) {
                        self.driveFolder = choice
                        self.update()
                    })
        }

        // upload to google
        this.onBackup = function () {
            var temp = RpgImpro.document

            cloudClient.saveFile(self.filename.value, 'application/json', JSON.stringify(temp), self.driveFolder.id)
                    .then(function (rsp) {
                        self.notice(temp.vertex.length + ' vertices saved', 'success')
                        self.parent.trigger('toggle-cloud')
                    })
        }

        this.onFilePicking = function () {
            cloudClient.pickOneFile('application/json')
                    .then(function (choice) {
                        console.log(choice)
                        self.backupName = choice.name

                        // folder info
                        var request = gapi.client.drive.files.get({
                            'fileId': choice.parentId
                        }).then(function (rsp) {
                            console.log(rsp)
                            self.driveFolder = rsp.result
                        })

                        // dl file content
                        gapi.client.drive.files.get({
                            fileId: choice.id,
                            alt: 'media'
                        }).then(function (rsp) {
                            var graph = rsp.result
                            RpgImpro.document.vertex = graph.vertex
                            RpgImpro.document.edge = graph.edge
                            RpgImpro.repository.vertex = graph.vertex
                            self.notice(graph.vertex.length + ' vertices imported', 'success')
                            self.parent.trigger('toggle-cloud')
                            RpgImpro.document.trigger('update')
                        })
                    }, function () {
                    })
        }

    </script>
</google-drive-doc>