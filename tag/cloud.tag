<cloud>
    <div class="pure-g">
        <div class="pure-u-1-2">{ driveFolder.name }</div>
        <div class="pure-u-1-2"><button class="pure-button" onclick="{
                    onFolderPicking
                }">Pick a folder</button></div>
    </div>
    <table class="pure-table pure-table-striped">
        <tr>
            <th>name</th>
            <th>id</th>
        </tr>
        <tr each="{listing}">
            <td>{name}</td>
            <td>{id}</td>
        </tr>
    </table>

    <div>{listing.length} élément(s)</div>

    <div class="pure-g" if="{ driveFolder.id }">
        <div class="pure-u-1-2"><button class="pure-button" onclick="{
                    onSaveToDrive
                }">Save to drive</button></div>
        <div class="pure-u-1-2"><button class="pure-button" onclick="{
                    onLoadFromDrive
                }">Load from drive</button></div>
    </div>

    <script>
        var self = this
        this.listing = []
        this.driveFolder = {}
        this.mixin('toasty')

        cloudClient.on('connected', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })

        onFolderPicking() {
            cloudClient.pickOneFolder()
                    .then(function (choice) {
                        self.trigger('folder-updated', choice)
                    })
        }

        this.on('folder-updated', function (entry) {
            self.driveFolder = entry

            // listing
            cloudClient.listing(entry.id).then(function (response) {
                if (response.result.files) {
                    self.listing = response.result.files
                    self.update()
                }
            });
        })

        onSaveToDrive() {
            repository.findAll().then(function(arr) {
                arr.forEach(function(item) {
                    // todo: promise batch
                    cloudClient.saveFile(item.name, 'application/json', JSON.stringify(item), self.driveFolder.id)
                })
                self.notice(arr.length + ' items saved', 'success')
            })
        }

        onLoadFromDrive() {
            cloudClient.listing(self.driveFolder.id).then(function (response) {
                for (var k = 0; k < response.result.files.length; k++) {
                    var fch = response.result.files[k]
                    gapi.client.drive.files.get({
                        fileId: fch.id,
                        alt: 'media'
                    }).then(function(rsp) {
                        repository.persist(rsp.result)
                    })
                }
                self.notice(response.result.files.length + ' items imported', 'success')
            })
        }

    </script>
</cloud>