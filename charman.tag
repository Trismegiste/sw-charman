<charman>
    <div class="pure-u-1-2">
        <nav class="pure-menu">
            <ul class="pure-menu-list">
                <li each="{ pc, i in characterList }" class="pure-menu-item">
                    <a href="#char/{ i }" class="pure-menu-link">{ pc.name }</a>
                </li>
            </ul>
        </nav>
        <div class="pure-g">
            <div class="pure-u-1-2">
                <a class="button-warning pure-button" onclick={ persist }>Save</a>
            </div>
            <div class="pure-u-1-2">
                <a class="pure-button pure-button-primary" onclick={ restore }>Load</a>
            </div>
        </div>
    </div>
    <div class="pure-u-1-2" id="pc-view">
        <form class="pure-form" onchange="{ updateModel }">
            <table class="pure-table pure-table-striped">
                <tbody>
                    <tr>
                        <th>Name</th><td><input type="text" name="name" value="{current.name}"/></td>
                    </tr>
                    <tr>
                        <th>Fighting</th>
                        <td>
                            <select name="fighting" value="{current.fighting}">
                                <option value="0"></option>
                                <option value="4">d4</option>
                                <option value="6">d6</option>
                                <option value="8">d8</option>
                                <option value="10">d10</option>
                                <option value="12">d12</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>Vigor</th>
                        <td>
                            <select name="vigor" value="{current.vigor}">
                                <option value="4">d4</option>
                                <option value="6">d6</option>
                                <option value="8">d8</option>
                                <option value="10">d10</option>
                                <option value="12">d12</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>Toughness</th><td>{current.getToughness()}</td>
                    </tr>
                    <tr>
                        <th>Parry</th><td>{current.getParry()}</td>
                    </tr>
                </tbody>
            </table>
            <div class="pure-g">
                <div class="pure-u-1-4 valign-widget">Wounds</div>
                <div class="pure-u-1-4">
                    <select name="wounds" value="{current.currentWounds}">
                        <option value="0">0</option>
                        <option value="-1">-1</option>
                        <option value="-2">-2</option>
                        <option value="-3">-3</option>
                        <option value="-4">Crit.</option>
                    </select>
                </div>
                <div class="pure-u-1-4 valign-widget">Fatigue</div>
                <div class="pure-u-1-4">
                    <select name="fatigue" value="{current.currentFatigue}">
                        <option value="0">0</option>
                        <option value="-1">-1</option>
                        <option value="-2">-2</option>
                        <option value="-4">Crit.</option>
                    </select>
                </div>
            </div>
            <div class="pure-g">
                <div class="pure-u-1-3 valign-widget">Spent token</div>
                <div class="pure-u-1-3">
                    <input type="number" name="token" value="{current.spentToken}"/>
                </div>
                <div class="pure-u-1-3 valign-widget">/ {current.getMaxToken()}</div>
            </div>
            <div class="pure-g">
                <div class="pure-u-1-2"><a class="pure-button button-error" onclick="{ onReset }">Reset</a></div>
                <div class="pure-u-1-2"><a class="pure-button pure-button-primary" onclick="{ onAppend }">Append</a></div>
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
                self.characterIndex = id;
            }
            self.update();
        });

        resetCurrent() {
            self.characterIndex = undefined;
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
            if (self.characterIndex !== undefined) {
                self.characterList[self.characterIndex] = self.current;
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
            self.current = {};
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
        }
    </script>
</charman>