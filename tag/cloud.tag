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
            <th></th>
        </tr>
        <tr each="{listing}">
            <td>{name}</td>
            <td>{id}</td>
            <td>{parents}</td>
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

        function findListingItem(name) {
            for(var k = 0; k < self.listing.length; k++) {
                if (self.listing[k].name === name) {
                    return k
                }
            }

            return -1
        }

        cloudClient.on('connected', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''

            cloudClient.saveFile('essai','application/json',JSON.stringify({aaa:456}),'0B9G7UC8VKdqDb2NKbkI4cy1ONG8')
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
                var temp = [];
                arr.forEach(function(localItem) {
                    var idx = findListingItem(localItem.name)
                    if (-1 === idx) {
                        cloudClient.uploadFile(localItem.name, 'application/json', JSON.stringify(localItem), self.driveFolder.id)
                    } else {
                        cloudClient.uploadFile(localItem.name, 'application/json', JSON.stringify(localItem), self.driveFolder.id, self.listing[idx].id)
                    }
                })
                self.notice(arr.length + ' items saved', 'success')
            })
        }

    </script>
</cloud>