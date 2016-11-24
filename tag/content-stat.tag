<content-stat class="webcomponent pure-g">
    <div class="pure-u-1 pure-u-md-1-2 pure-u-xl-1-3">
        <form class="pure-form pure-g form-label-aligned" onchange="{ updateCurrent }">
            <div class="pure-u-1-4"><label>Nom</label></div>
            <div class="pure-u-3-4"><input class="pure-input-1" type="text" name="name" value="{model.current.name}" required="true"/></div>
            <div class="pure-u-1-4"><label>Cible</label></div>
            <div class="pure-u-3-4">
                <select class="pure-input-1" name="target" value="{model.current.target}">
                    <option value=""></option>
                    <option each="{model.characterList}" value="{name}">{name}</option>
                </select>
            </div>
            <div class="pure-u-1-4"><label>Attaq.</label></div>
            <div class="pure-u-1-4">
                <select name="attack" value="{model.current.attack}" data-is="dice-option"></select>
            </div>
            <div class="pure-u-1-2">
                <label class="pure-checkbox">
                    Secoué
                    <input type="checkbox" name="shaken" checked="{ model.current.shaken }"/>
                </label>
            </div>
            <div class="pure-u-1-4"><label>Dégâts</label></div>
            <div class="pure-u-3-4">
                <input type="text" name="damage" value="{ model.current.damage }" class="pure-input-1"/>
            </div>
            <div class="pure-u-1-4"><label>Parade</label></div>
            <div class="pure-u-1-4"><input type="number" value="{model.current.toHit}" name="toHit" class="pure-input-1"/></div>
            <div class="pure-u-1-4"><label>Résis.</label></div>
            <div class="pure-u-1-4"><input type="number" value="{model.current.toughness}" name="toughness" class="pure-input-1"/></div>
            <div class="pure-u-1-4"><label>Bless.</label></div>
            <div class="pure-u-1-4">
                <select name="wounds" value="{model.current.currentWounds}">
                    <option value="0">0</option>
                    <option value="-1">-1</option>
                    <option value="-2">-2</option>
                    <option value="-3">-3</option>
                    <option value="-4">Crit.</option>
                </select>
            </div>
            <div class="pure-u-1-4"><label>Jeton</label></div>
            <div class="pure-u-1-4">
                <select name="token" value="{model.current.spentToken}" max="{model.current.getMaxToken()}" data-is="token-option" class="pure-input-1">
                </select>
            </div>
        </form>
        <div class="pure-g button-spacing">
            <div class="pure-u-1-3"><a class="pure-button" onclick="{ onReset }">Reset</a></div>
            <div class="pure-u-1-3"><a class="pure-button button-primary" onclick="{ onAppend }">Append</a></div>
            <div class="pure-u-1-3"><a class="pure-button button-error" onclick="{ onDelete }">Delete</a></div>
        </div>
        <div class="pure-g button-spacing">
            <div class="pure-u-1"><a class="pure-button button-success" onclick="{ storeToRepository }">Store to DB</a></div>
        </div>
    </div>
    <script>
        this.mixin('toasty')
        this.model = SwCharman.model
        var self = this

        onReset() {
            self.model.trigger('reset');
            riot.route('stat');
        }

        onAppend() {
            // checking non-empty name
            if (self.name.value == '') {
                return;
            }
            self.model.current = self.model.clone(self.model.current)
            self.model.characterList.push(self.model.current);
            self.notice(self.model.current.name + ' created', 'success')
            riot.route('char/' + (self.model.characterList.length - 1));
        }

        onDelete() {
            var idx = self.model.characterList.indexOf(self.model.current);
            if (idx !== -1) {
                self.model.characterList.splice(idx, 1);
                self.notice(self.model.current.name + ' deleted', 'error')
                riot.route('list');
            }
        }

        updateCurrent() {
            var obj = self.model.current;
            obj.name = self.name.value;
            obj.toughness = self.toughness.value;
            obj.attack = self.attack.value;
            obj.damage = self.damage.value;
            obj.toHit = self.toHit.value;
            obj.currentWounds = self.wounds.value;
            obj.shaken = self.shaken.checked;
            obj.spentToken = self.token.value;
            obj.target = self.target.value;
        }

        // store the current char into the Repository
        storeToRepository() {
            if (self.model.current.name != '') {
                var temp = self.model.clone(self.model.current);
                temp.restart();
                SwCharman.repository.persist(temp)
                        .then(function() {
                            self.notice(temp.name + ' stored', 'success')
                            self.model.trigger('update-db');
                        })
            }
        }

        var subRoute = riot.route.create()
        subRoute('/char/*', function (id) {
            self.model.trigger('reset');
            if (self.model.characterList[id] !== undefined) {
                self.model.current = self.model.characterList[id];
            }
            subRoute('stat', 'Stat ' + self.model.current.name, true)
        });
    </script>
</content-stat>
