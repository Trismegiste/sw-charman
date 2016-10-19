<dump-database>
    <footer class="pure-g button-spacing">
        <div class="pure-u-1-1"><form class="pure-form"><input type="text" name="dumpdb" class="pure-input-1" value="{ dumpContent }"/></form></div>
        <div class="pure-u-1-2"><a class="pure-button pure-input-1" onclick="{ onDump }">Dump DB</a></div>
        <div class="pure-u-1-2"><a class="pure-button pure-input-1 button-error" onclick="{ onCreate }">Create DB</a></div>
    </footer>

    <script>
        this.dumpContent = ''
        self = this

        onDump() {
            this.opts.repository.findAll().then(function(arr) {
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
                this.opts.repository.createFromDump(self.dumpdb.value)
            }
        }
    </script>
</dump-database>
