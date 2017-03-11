<cloud>
    <table class="pure-table pure-table-striped">
        <tr>
            <th>name</th>
            <th>id</th>
        </tr>
        <tr each="{listing}">
            <td>{name}</td>
            <td>{pk}</td>
            <td>{folder}</td>
        </tr>
    </table>
    <script>
        var self = this
        this.listing = []
        // application/vnd.google-apps.folder

        cloudClient.on('connected', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''

            // listing
            gapi.client.drive.files.list({
                pageSize: 10,
                fields: "nextPageToken, files(id, name, parents)",
                q: "name='dump.json'"
            }).then(function (response) {
                var listing = []
                var files = response.result.files;
                if (files && files.length > 0) {
                    for (var i = 0; i < files.length; i++) {
                        var file = files[i];
                        console.log(file)
                        listing.push({name: file.name, pk: file.id, folder: file.parents[0]});
                    }
                }
                self.trigger('listed', listing)
            });
        })

        this.on('listed', function (listing) {
            self.listing = listing
            self.update()
            cloudClient.createPicker()
        })


    </script>
</cloud>