<charman>
    <div class="pure-u-1-2">
        <nav class="pure-menu">
            <ul class="pure-menu-list">
                <li each="{ characterList }" class="pure-menu-item">
                    <a href="#char/{ name }" class="pure-menu-link">{ name }</a>
                </li>
            </ul>
        </nav>
        <div class="pure-g">
            <form class="pure-form">
                <button class="pure-u-1-2 pure-button" onclick={ persist }>Save</button>
                <button class="pure-u-1-2 pure-button" onclick={ restore }>Load</button>
            </form>
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
                                <option value=""></option>
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
        </form>
    </div>

    <script>

        this.characterList = [];
        self = this;

        riot.route('/', function () {
            console.log('The list of char');
            self.current = {};
            self.update();
        });

        riot.route('/char/*', function (name) {
            console.log('View ' + name);
            self.current = {};
            self.characterList.forEach(function (item) {
                if (item.name === name) {
                    self.current = item;
                }
            });
            self.update();
        });

        updateModel() {
            self.characterList.forEach(function (item) {
                if (item.name === self.current.name) {
                    item.vigor = self.vigor.value;
                    item.fighting = self.fighting.value;
                    item.currentWounds = self.wounds.value;
                    item.currentFatigue = self.fatigue.value;
                    item.spentToken = self.token.value;
                    self.current = item;
                    return;
                }
            });
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
    </script>
</charman>