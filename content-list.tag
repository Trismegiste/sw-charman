<content-list>
    <nav class="pure-menu char-list">
        <ul class="pure-menu-list">
            <li each="{ pc, i in characterList }" class="pure-menu-item">
                <a href="#char/{ i }" class="pure-menu-link">{ pc.name } [vs {pc.target} / W:{pc.currentWounds}{pc.shaken ? '+S' : ''}]</a>
            </li>
        </ul>
    </nav>
    <footer class="pure-g button-spacing">
        <div class="pure-u-1-2"><a class="pure-button pure-button-primary" onclick="{
                    restore
                }">Load</a></div>
        <div class="pure-u-1-2"><a class="pure-button button-error" onclick="{
                    persist
                }">Save</a></div>
    </footer>

    <script>
        this.mixin('toasty')
        this.characterList = []
        var self = this
        self.current = new Character();

        persist() {
            self.opts.repo.saveCurrent(self.characterList);
            self.notice('Current state saved', 'success')
        };

        restore() {
            self.characterList = [];
            self.opts.repo.loadCurrent()
                .then(function (arr) {
                    console.log('load ' + arr.length);
                    arr.forEach(function (item) {
                        self.characterList.push(item);
                    })
                    self.update();
                    riot.route('/');
                })
        };
    </script>
</content-list>