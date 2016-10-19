<charman>
    <div class="pure-u-1-1 pure-u-md-1-2">
        <nav class="pure-menu pure-menu-horizontal top-menu">
            <ul class="pure-menu-list">
                <li class="pure-menu-item"><a href="#" class="pure-menu-link" onclick={ persist }>Save</a></li>
                <li class="pure-menu-item"><a href="#" class="pure-menu-link" onclick={ restore }>Load</a></li>
                <li class="pure-menu-item"><a href="#" class="pure-menu-link" onclick={ export }>Export</a></li>
                <li class="pure-menu-item"><a href="#" class="pure-menu-link" onclick={ import }>{ openedRepository ? 'Close' : 'Import'}</a></li>
            </ul>
        </nav>
        <listing-repository if="{ openedRepository }" repository="{ opts.repo }"></listing-repository>
        <nav class="pure-menu char-list">
            <ul class="pure-menu-list">
                <li each="{ pc, i in characterList }" class="pure-menu-item">
                    <a href="#char/{ i }" class="pure-menu-link">{ pc.name } [vs {pc.target} / W:{pc.currentWounds}{pc.shaken ? '+S' : ''}]</a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="pure-u-1-1 pure-u-md-1-2" id="pc-view">
        <form class="pure-form pure-g" onchange="{ updateModel }">
            <div class="pure-u-1-4"><label>Name</label></div>
            <div class="pure-u-3-4"><input class="pure-input-1" type="text" name="name" value="{current.name}" required="true"/></div>
            <div class="pure-u-1-4"><label>Target</label></div>
            <div class="pure-u-3-4">
                <select class="pure-input-1" name="target" value="{current.target}">
                    <option value=""></option>
                    <option each="{characterList}" value="{name}">{name}</option>
                </select>
            </div>
            <div class="pure-u-1-4"><label>Attack</label></div>
            <div class="pure-u-1-4">
                <select name="attack" value="{current.attack}">
                    <option value="0"></option>
                    <option value="4">d4</option>
                    <option value="6">d6</option>
                    <option value="8">d8</option>
                    <option value="10">d10</option>
                    <option value="12">d12</option>
                </select>
            </div>
            <div class="pure-u-1-2">
                <label class="pure-checkbox">
                    Shaken
                    <input type="checkbox" name="shaken" checked="{ current.shaken }"/>
                </label>
            </div>
            <div class="pure-u-1-4"><label>Damage</label></div>
            <div class="pure-u-3-4">
                <input type="text" name="damage" value="{ current.damage }" class="pure-input-1"/>
            </div>
            <div class="pure-u-1-4"><label>To Hit</label></div>
            <div class="pure-u-1-4"><input type="number" value="{current.toHit}" name="toHit" class="pure-input-2-3"/></div>
            <div class="pure-u-1-4"><label>Toughness</label></div>
            <div class="pure-u-1-4"><input type="number" value="{current.toughness}" name="toughness" class="pure-input-2-3"/></div>
            <div class="pure-u-1-4"><label>Wounds</label></div>
            <div class="pure-u-1-4">
                <select name="wounds" value="{current.currentWounds}">
                    <option value="0">0</option>
                    <option value="-1">-1</option>
                    <option value="-2">-2</option>
                    <option value="-3">-3</option>
                    <option value="-4">Crit.</option>
                </select>
            </div>
            <div class="pure-u-1-4"><label>Token</label></div>
            <div class="pure-u-1-4">
                <select name="token" value="{current.spentToken}" max="{current.getMaxToken()}" riot-tag="token-select">
                </select>
            </div>
        </form>
        <footer class="pure-g button-spacing">
            <div class="pure-u-1-3"><a class="pure-button" onclick="{ onReset }">Reset</a></div>
            <div class="pure-u-1-3"><a class="pure-button pure-button-primary" onclick="{ onAppend }">Append</a></div>
            <div class="pure-u-1-3"><a class="pure-button button-error" onclick="{ onDelete }">Delete</a></div>
        </footer>
        <dump-database repository="{ opts.repo }"></dump-database>
    </div>

    <script>

        this.characterList = []
        var self = this
        self.current = new Character();
        self.openedRepository = false;

        riot.route('/', function () {
            console.log('The list of char');
            self.resetCurrent();
            self.update();
        });

        riot.route('/char/*', function (id) {
            self.resetCurrent();
            if (self.characterList[id] !== undefined) {
                self.current = self.characterList[id];
            }
            self.update();
        });

        resetCurrent() {
            self.current = new Character();
        }

        updateCurrent() {
            self.current.name = self.name.value;
            self.current.toughness = self.toughness.value;
            self.current.attack = self.attack.value;
            self.current.damage = self.damage.value;
            self.current.toHit = self.toHit.value;
            self.current.currentWounds = self.wounds.value;
            self.current.shaken = self.shaken.checked;
            self.current.spentToken = self.token.value;
            self.current.target = self.target.value;
        }

        updateModel() {
            self.updateCurrent();
            var idx = self.characterList.indexOf(self.current);
            if (idx !== -1) {
                self.characterList[idx] = self.current;
            }
        }

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

        onReset() {
            self.resetCurrent()
            riot.route('/');
        }

        onAppend() {
            // checking non-empty name
            if (self.name.value == '') {
                return;
            }
            // checking
            self.resetCurrent();
            self.updateCurrent();
            self.characterList.push(self.current);
            riot.route('/char/' + (self.characterList.length - 1));
        }

        onDelete() {
            var idx = self.characterList.indexOf(self.current);
            if (idx !== -1) {
                self.characterList.splice(idx, 1);
            }
            riot.route('/');
        }

        // export the current form
        export() {
            if (self.current.name != '') {
                var temp = Object.assign(Object.create(self.current), self.current);
                temp.restart();
                self.opts.repo.persist(temp)
                        .then(function() {
                            self.update();
                        })
                self.notice(temp.name + ' stored', 'success')
            }
        }

        notice(msg, level) {
            var tags = riot.mount('rg-toasts', {
                toasts: {
                    position: 'bottomright',
                    toasts: [{
                            type: level,
                            text: msg,
                            timeout: 2000
                    }]
                }
            });
        }

        import() {
            self.openedRepository = ! self.openedRepository
            self.update()
        }
    </script>
</charman>

<token-select>
    <option each="{val, idx in tokenChoices}" value="{idx}">{val}</option>

    <script>
        this.tokenChoices = [];
        var self = this;

        this.on('update', function() {
            for(var k=0; k<=self.opts.max; k++) {
                self.tokenChoices[k] = k;
            }
        });
    </script>
</token-select>

<listing-repository>
    <table class="pure-table pure-table-striped v-spacing">
        <tr each="{ listing }">
            <td><a href="#" onclick="{ parent.onAppend }">{name}</a></td>
            <td><a href="#" class="pure-button button-error" onclick="{ parent.onDelete }">&times;</a></td>
        </tr>
    </table>
    <script>
        var self = this;
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
                console.log('found '+pc.name);
                self.parent.characterList.push(pc);
                //self.parent.update()
                riot.route('/char/' + (self.parent.characterList.length - 1))
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
</listing-repository>

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
