<cloud>
    <div class="pure-g">
        <div class="pure-u-2-3">
            <section class="panel folder placeholder" if="{ !driveFolder.id }">Pick a folder on Google Drive</section>
            <section class="panel folder" if="{ driveFolder.id }">{ driveFolder.name }</section>
        </div>
        <div class="pure-u-1-3">
            <section class="panel">
                <button class="pure-button" onclick="{onFolderPicking}">
                    <i class="icon-google-drive"></i>
                </button>
            </section>
        </div>
    </div>
    <div class="pure-g dashboard">
        <div class="pure-u-1-2">
            <section>
                <i class="icon-database"></i>
                <p>{ listing.local.length } éléments</p>
            </section>
        </div>
        <div class="pure-u-1-2">
            <section>
                <i class="icon-google-drive"></i>
                <p if="{ driveFolder.id }">{ listing.remote.length } éléments</p>
            </section>
        </div>
        <div class="pure-u-1-2" if="{ driveFolder.id }">
            <section>
                <button class="pure-button button-primary" onclick="{
                    onLoadFromDrive
                }">
                    <i class="icon-download-cloud"></i>
                </button>
            </section>
        </div>
        <div class="pure-u-1-2" if="{ driveFolder.id }">
            <section>
                <button class="pure-button button-error" onclick="{
                    onSaveToDrive
                }">
                    <i class="icon-upload-cloud"></i>
                </button>
            </section>
        </div>
    </div>

    <script>
        var self = this
        this.listing = {remote: [], local: []}
        this.driveFolder = {}
        this.mixin('toasty')

        cloudClient.on('connected', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
            self.trigger('update-database')
        })

        onFolderPicking() {
            cloudClient.pickOneFolder()
                    .then(function (choice) {
                        self.trigger('folder-updated', choice)
                        self.trigger('update-database')
                    })
        }

        this.on('folder-updated', function (entry) {
            self.driveFolder = entry

            // listing
            cloudClient.listing(entry.id, 'application/json').then(function (response) {
                if (response.result.files) {
                    self.listing.remote = response.result.files
                    self.update()
                }
            })
        })

        this.on('update-database', function () {
            repository.findAll().then(function(arr) {
                    self.listing.local = arr
                    self.update()
            })
        })

        onSaveToDrive() {
            repository.findAll().then(function(arr) {
                var actions = []
                for(var idx = 0; idx < arr.length; idx++) {
                    var item = arr[idx]
                    actions.push(cloudClient.saveFile(item.name, 'application/json', JSON.stringify(item), self.driveFolder.id))
                }
                Promise.all(actions).then(function(rsp) {
                    var cpt = 0
                    for(var k=0; k<rsp.length; k++) {
                        cpt += (rsp[k].status === 200) ? 1 : 0
                    }
                    if (cpt === arr.length) {
                        self.notice(cpt + ' items saved', 'success')
                    } else {
                        self.notice('Unable to save ' + (arr.length - cpt) + ' items', 'error')
                    }
                })
            })
        }

        onLoadFromDrive() {
            cloudClient.listing(self.driveFolder.id).then(function (response) {
                var batch = []
                for (var k = 0; k < response.result.files.length; k++) {
                    var fch = response.result.files[k]
                    batch.push(gapi.client.drive.files.get({
                        fileId: fch.id,
                        alt: 'media'
                    }).then(function(rsp) {
                        return repository.persist(rsp.result)
                    }))
                }
                Promise.all(batch).then(function(rsp) {
                    self.notice(rsp.length + ' items imported', 'success')
                })
            })
        }

    </script>
</cloud>