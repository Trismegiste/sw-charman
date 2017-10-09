<google-drive-doc>
    <div if="{ !isAuthenticated() }" class="connexion">
        <a class="pure-button" onclick="{
                    onConnect
                }">Connexion</a>
    </div>
    <form if="{ isAuthenticated() }" class="pure-form form-label-aligned" onsubmit="{
                onBackup
            }">
        <div class="pure-g">
            <div class="pure-u-1-4"></div>
            <div class="pure-u-3-4">
                <button class="pure-button button-primary pure-input-1" onclick="{
                            onFilePicking
                        }">Load</button>
            </div>
            <div class="pure-u-1-4"><label>Nom</label></div>
            <div class="pure-u-3-4"><input class="pure-input-1" type="text"
                                           name="filename" value="{SwCharman.cloudFile.name}"
                                           placeholder="A filename to backup to"
                                           required="true"/>
            </div>
            <div class="pure-u-1-4"><label>Folder</label></div>
            <div class="pure-u-3-4"><input class="pure-input-1" type="text"
                                           name="folder" required="true" readonly="true"
                                           value="{SwCharman.cloudFolder.name}"
                                           placeholder="Click to pick a folder"
                                           onclick="{
                                                       onFolderPicking
                                                   }"/>
            </div>
        </div>
    </form>

    <script>
        var self = this
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
                        SwCharman.cloudFolder = choice
                        self.update()
                    })
        }

        this.onFilePicking = function () {
            cloudClient.pickOneFile('application/json')
                    .then(function (choice) {
                        console.log(choice)
                        SwCharman.cloudFile = choice

                        // folder info
                        var request = gapi.client.drive.files.get({
                            'fileId': choice.parentId
                        }).then(function (rsp) {
                            console.log(rsp)
                            SwCharman.cloudFolder = rsp.result
                        })

                        // dl file content
                        gapi.client.drive.files.get({
                            fileId: choice.id,
                            alt: 'media'
                        }).then(function (rsp) {
                            SwCharman.model.trigger('update-db', rsp.result)
                        })
                    }, function () {
                    })
        }

    </script>
</google-drive-doc>