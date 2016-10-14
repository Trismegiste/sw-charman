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
                <button class="pure-u-1-2 pure-button">New</button>
                <button class="pure-u-1-2 pure-button">Del</button>
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
                </tbody>
            </table>
        </form>
    </div>

    <script>
        var pc1 = new Character();
        pc1.name = 'Arkel';
        pc1.fighting = 8;

        var pc2 = new Character();
        pc2.name = 'Dracka';
        pc2.fighting = 12;

        this.characterList = [pc1, pc2];
        this.current = {};
        self = this;

        riot.route('/char/*', function (name) {
            console.log('View ' + name);
            self.characterList.forEach(function (item) {
                if (item.name === name) {
                    self.current = item;
                    self.update();
                }
            });
        });
    </script>
</charman>