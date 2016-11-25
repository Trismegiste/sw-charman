<dump-database class="webcomponent">
    <div class="pure-g">
        <div class="pure-u-1-1">
            <form class="pure-form">
                <h2>Dump/create DB</h2>
                <input type="text" name="dumpdb" class="pure-input-1" value="{ dumpContent }"/>
            </form>
        </div>
    </div>
    <footer class="pure-g button-spacing">
        <div class="pure-u-1-2"><a class="pure-button pure-input-1 button-primary" onclick="{ onDump }">Dump DB</a></div>
        <div class="pure-u-1-2"><a class="pure-button pure-input-1 button-error" onclick="{ onCreate }">Create DB</a></div>
    </footer>

    <script>
        this.dumpContent = ''
        var self = this
        this.mixin('toasty')

        onDump() {
            SwCharman.repository.findAll().then(function(arr) {
                var temp = [];
                arr.forEach(function(item, idx) {
                    temp.push(item);
                })
                self.dumpContent = JSON.stringify(temp);
                self.update()
            })
        }

        onCreate() {
            if (self.dumpdb.value != '') {
                SwCharman.repository.createFromDump(self.dumpdb.value)
                self.notice('Création du Repository', 'error')
                SwCharman.model.trigger('update-db')
            }
        }

        var subRoute = riot.route.create()
        subRoute('/dump', function () {
            self.parent.activeTab = 'dump'
            self.parent.update()
        });
    </script>
</dump-database>
