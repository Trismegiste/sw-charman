<charman>
    <div class="pure-u-1-1 pure-u-md-1-2">
        <nav class="pure-menu pure-menu-horizontal">
            <ul class="pure-menu-list">
                <li class="pure-menu-item"><a href="#" class="pure-menu-link" onclick={ persist }>Save</a></li>
                <li class="pure-menu-item"><a href="#" class="pure-menu-link" onclick={ restore }>Load</a></li>
                <li class="pure-menu-item"><a href="#" class="pure-menu-link" onclick={ export }>Export</a></li>
                <li class="pure-menu-item"><a href="#" class="pure-menu-link" onclick={ import }>Import</a></li>
            </ul>
        </nav>
        <nav class="pure-menu char-list">
            <ul class="pure-menu-list">
                <li each="{ pc, i in characterList }" class="pure-menu-item">
                    <a href="#char/{ i }" class="pure-menu-link">{ pc.name } (vs XXX W:{pc.currentWounds})</a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="pure-u-1-1 pure-u-md-1-2" id="pc-view">
        <form class="pure-form" onchange="{ updateModel }">
            <fieldset class="pure-g">
                <div class="pure-u-1-4"><label>Name</label></div>
                <div class="pure-u-3-4"><input class="pure-input-1" type="text" name="name" value="{current.name}" required="true"/></div>
                <div class="pure-u-1-4"><label>Fighting</label></div>
                <div class="pure-u-1-4">
                    <select name="fighting" value="{current.fighting}">
                        <option value="0"></option>
                        <option value="4">d4</option>
                        <option value="6">d6</option>
                        <option value="8">d8</option>
                        <option value="10">d10</option>
                        <option value="12">d12</option>
                    </select>
                </div>
                <div class="pure-u-1-4"><label>Vigor</label></div>
                <div class="pure-u-1-4">
                    <select name="vigor" value="{current.vigor}">
                        <option value="4">d4</option>
                        <option value="6">d6</option>
                        <option value="8">d8</option>
                        <option value="10">d10</option>
                        <option value="12">d12</option>
                    </select>
                </div>
                <div class="pure-u-1-4"><label>Toughness</label></div>
                <div class="pure-u-1-4"><label>{current.getToughness()}</label></div>
                <div class="pure-u-1-4"><label>Parry</label></div>
                <div class="pure-u-1-4"><label>{current.getParry()}</label></div>
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
                <div class="pure-u-1-4"><label>Fatigue</label></div>
                <div class="pure-u-1-4">
                    <select name="fatigue" value="{current.currentFatigue}">
                        <option value="0">0</option>
                        <option value="-1">-1</option>
                        <option value="-2">-2</option>
                        <option value="-4">Crit.</option>
                    </select>
                </div>
                <div class="pure-u-1-3"><label>Spent token</label></div>
                <div class="pure-u-1-3">
                    <input type="number" name="token" value="{current.spentToken}" class="pure-input-1"/>
                </div>
                <div class="pure-u-1-3"><label>/ {current.getMaxToken()}</label></div>
            </fieldset>
            <div class="pure-g">
                <div class="pure-u-1-3"><a class="pure-button" onclick="{ onReset }">Reset</a></div>
                <div class="pure-u-1-3"><a class="pure-button pure-button-primary" onclick="{ onAppend }">Append</a></div>
                <div class="pure-u-1-3"><a class="pure-button button-error" onclick="{ onDelete }">Delete</a></div>
            </div>
        </form>
    </div>

    <script>

        this.characterList = [];
        self = this;

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
            self.current.vigor = self.vigor.value;
            self.current.fighting = self.fighting.value;
            self.current.currentWounds = self.wounds.value;
            self.current.currentFatigue = self.fatigue.value;
            self.current.spentToken = self.token.value;
        }

        updateModel() {
            self.updateCurrent();
            var idx = self.characterList.indexOf(self.current);
            if (idx !== -1) {
                self.characterList[idx] = self.current;
            }
        }

        persist() {
            localStorage.setItem('sw-character-list', JSON.stringify(self.characterList));
        };

        restore() {
           var flat = JSON.parse(localStorage.getItem('sw-character-list'));
           self.characterList = [];

           flat.forEach(function(item) {
               Object.keys(Character.prototype).forEach(function(key){
                   item[key] = Character.prototype[key];
               });
               self.characterList.push(item);
           })
           riot.route('/');
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
    </script>
</charman>