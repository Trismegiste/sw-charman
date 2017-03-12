<cloud>
    <div class="pure-g">
        <div class="pure-u-1-2">{ driveFolder }</div>
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
    <script>
        var self = this
        this.listing = []

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
            self.driveFolder = entry.name

            // listing
            gapi.client.drive.files.list({
                pageSize: 100,
                fields: "nextPageToken, files(id, name, parents)",
                q: "'" + entry.id + "' in parents and trashed=false"
            }).then(function (response) {
                if (response.result.files) {
                    self.listing = response.result.files
                    self.update()
                }
            });
        })

    </script>
</cloud>