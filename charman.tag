<die-select>
    <select name="{ opts.name }">
        <option value=""></option>
        <option value="4">d4</option>
        <option value="6">d6</option>
        <option value="8">d8</option>
        <option value="10">d10</option>
        <option value="12">d12</option>
    </select>

    <script>
        this.on('update', function () {
            // Appel à querySelector contextualisé
            $(this.root.querySelectorAll('select')).val(this.opts.value);
        });
    </script>
</die-select>
<charman>
    <div class="pure-u-1-2">
        <ul>
            <li each={ characterList }><a href="#char/{ name }">{ name }</a></li>
        </ul>
        <div class="pure-g">
            <form class="pure-form">
                <button class="pure-u-1-2 pure-button" onclick={ persist }>Save</button>
                <button class="pure-u-1-2 pure-button" onclick={ restore }>Load</button>
            </form>
        </div>
    </div>
    <div class="pure-u-1-2" id="pc-view">
        <form class="pure-form">
            <table class="pure-table pure-table-striped">
                <tbody>
                    <tr>
                        <th>Name</th><td><input type="text" name="name" value="{current.name}"/></td>
                    </tr>
                    <tr>
                        <th>Fighting</th><td><die-select name="fighting" value="{current.fighting}"></die-select></td>
                    </tr>
                    <tr>
                        <th>Vigor</th><td><die-select name="vigor" value="{current.vigor}"></die-select></td>
                    </tr>
                    <tr>
                        <th>Toughness</th><td>{current.getToughness()}</td>
                    </tr>
                </tbody>
            </table>
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
            console.log(self.name.value)
            console.log(self.fighting.value)
            console.log(self.vigor.value)

            self.current.vigor = self.vigor.value;
            console.log(self.current)
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