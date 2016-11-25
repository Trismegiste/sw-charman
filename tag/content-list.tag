<content-list>
    <nav class="pure-menu">
        <ul class="pure-menu-list">
            <li each="{ pc, i in model.characterList }" class="pure-menu-item">
                <a href="#char/{ i }" class="pure-menu-link">
                    { pc.name } [vs {pc.target} / W:{pc.currentWounds}{pc.shaken ? '+S' : ''}]
                </a>
            </li>
        </ul>
    </nav>
    <footer class="pure-g button-spacing">
        <div class="pure-u-1-2"><a class="pure-button button-primary" onclick="{
                    restore
                }">Load</a></div>
        <div class="pure-u-1-2"><a class="pure-button button-error" onclick="{
                    persist
                }">Save</a></div>
    </footer>

    <script>
        this.mixin('toasty')
        this.model = SwCharman.model
        var self = this

        persist() {
            SwCharman.repository.saveCurrent(self.model.characterList);
            self.notice('Etat courant enregistré', 'error')
        };

        restore() {
            self.model.characterList = [];
            SwCharman.repository.loadCurrent()
                .then(function (arr) {
                    console.log('load ' + arr.length);
                    arr.forEach(function (item) {
                        self.model.characterList.push(item);
                    })
                    self.update();
                })
        };

    </script>
</content-list>