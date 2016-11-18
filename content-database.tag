<content-database>
    <table class="pure-table pure-table-striped v-spacing" style="width: 100%">
        <tr each="{ listing }">
            <td><a href="#" onclick="{ parent.onAppend }">{name}</a></td>
            <td>{getLethality()}</td>
            <td><a href="#" class="pure-button button-error" onclick="{ parent.onDelete }">&times;</a></td>
        </tr>
    </table>
    <script>
        this.mixin('toasty')
        this.mixin('model')
        var self = this

        self.listing = [];

        this.on('update', function() {
            console.log('refresh')
            self.opts.repository.findAll()
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
            self.opts.repository.findByPk(item.name).then(function(pc) {
                console.log('found ' + pc.name);
                self.model.characterList.push(pc);
                self.notice(pc.name + ' added', 'success')
            })
        }

        onDelete(event) {
            // looped item
            var item = event.item
            self.opts.repository.deleteByPk(item.name).then(function() {
                console.log('delete '+item.name);
                // because item is not a Character (bad cloning ?), indexOf is not working
                self.listing.forEach(function(obj, idx) {
                    if (obj.name === item.name) {  // name is unique in DB
                        self.listing.splice(idx, 1)
                    }
                })
                self.update()
            })
        }
    </script>
</content-database>
