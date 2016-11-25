<content-database>
    <table class="pure-table pure-table-striped v-spacing" style="width: 100%">
        <tr each="{ listing }">
            <td><input type="radio" name="radiochoice" value="{name}"/></td>
            <td><a href="#" onclick="{ parent.onAppend }">{name}</a></td>
        </tr>
    </table>
    <footer class="pure-g button-spacing">
        <div class="pure-u-1-4">
            <a target="_blank" href="#" class="pure-button button-primary"><i class="icon-file-pdf"></i></a>
        </div>
        <div class="pure-u-1-2">
            <a href="#dump" class="pure-button button-warning">Dump/create DB</a>
        </div>
        <div class="pure-u-1-4">
            <a href="#" class="pure-button button-error" onclick="{ }"><i class="icon-trash-empty"></i></a>
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
                     .then(function(arr){
                        self.listing = [];
                         arr.forEach(function(obj){
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

        onDelete(event) {
            // looped item
            var item = event.item
            SwCharman.repository.deleteByPk(item.name).then(function() {
                self.notice(item.name + ' effacé', 'error')
                // because item is not a Character (bad cloning ?), indexOf is not working
                self.listing.forEach(function(obj, idx) {
                    if (obj.name === item.name) {  // name is unique in DB
                        self.listing.splice(idx, 1)
                    }
                })
                self.update()
            })
        }

        this.model.on('update-db', function() {
            self.update()
        })
    </script>
</content-database>
