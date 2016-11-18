<content-list>
    <nav class="pure-menu char-list">
        <ul class="pure-menu-list">
            <li each="{ pc, i in model.characterList }" class="pure-menu-item">
                <a href="#char/{ i }" class="pure-menu-link">
                    { pc.name } [vs {pc.target} / W:{pc.currentWounds}{pc.shaken ? '+S' : ''}]
                </a>
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
        this.mixin('model')
        var self = this

        persist() {
            self.opts.repo.saveCurrent(self.model.characterList);
            self.notice('Current state saved', 'success')
        };

        restore() {
            self.model.characterList = [];
            self.opts.repo.loadCurrent()
                .then(function (arr) {
                    console.log('load ' + arr.length);
                    arr.forEach(function (item) {
                        self.model.characterList.push(item);
                    })
                    self.update();
                })
        };

        var subRoute = riot.route.create()
        subRoute('/char/*', function (id) {
            self.model.trigger('reset');
            if (self.model.characterList[id] !== undefined) {
                self.model.current = self.model.characterList[id];
            }
            subRoute('stat',self.model.current.name,true)
        });
    </script>
</content-list>