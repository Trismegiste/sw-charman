<content-database>
    <table class="pure-table pure-table-striped checkable-listing" style="width: 100%">
        <tr each="{ listing }">
            <td>
                <input type="radio" name="radiochoice" value="{name}"/>
                <a href="#" onclick="{ parent.onAppend }">{name}</a>
                <i class="icon-{ type }"></i>
            </td>
        </tr>
    </table>
    <footer class="pure-g button-spacing">
        <div class="pure-u-1-4">
            <a href="#" class="pure-button button-primary" onclick="{ onPdf }"><i class="icon-file-pdf"></i></a>
        </div>
        <div class="pure-u-1-2">
            <a href="cloud.html" target="_blank" class="pure-button"><i class="icon-google-drive"></i></a>
        </div>
        <div class="pure-u-1-4">
            <a href="#" class="pure-button button-error" onclick="{ onDelete }"><i class="icon-trash-empty"></i></a>
        </div>
    </footer>
    <script>
        this.mixin('toasty')
        this.model = SwCharman.model
        var self = this

        self.listing = [];

        this.on('update', function() {
            console.log('refresh')
            SwCharman.repository.findAll()
                    .then(function(arr) {
                        self.listing = [];
                        arr.forEach(function(obj) {
                            self.listing.push(obj);
                        })
                    })
        })

        onAppend(event) {
            // looped item
            var item = event.item
            SwCharman.repository.findByPk(item.name).then(function(pc) {
                console.log('found ' + pc.name);
                self.model.characterList.push(pc);
                self.notice(pc.name + ' ajouté', 'primary')
            })
        }

        onDelete() {
            // search the checked radio
            var item = self.radio
            for(var idx in self.radiochoice) {
                var radio = self.radiochoice[idx]
                if (radio.checked) {
                    radio.checked = false;
                    var name = radio.value
                    SwCharman.repository.deleteByPk(name).then(function() {
                        self.notice(name + ' effacé', 'error')
                        // updating listing because, dexie returns only promise
                        self.listing.forEach(function(obj, idx) {
                            if (obj.name === name) {  // name is unique in DB
                                self.listing.splice(idx, 1)
                            }
                        })
                        self.update()
                    })
                }
            }
        }

        onPdf() {
            // search the checked radio
            var item = self.radio
            for(var idx in self.radiochoice) {
                var radio = self.radiochoice[idx]
                if (radio.checked) {
                    radio.checked = false;
                    window.open('pdf.html?key=' + encodeURIComponent(radio.value), '_blank')
                }
            }
        }

        this.model.on('update-db', function() {
            self.update()
        })
    </script>
</content-database>
