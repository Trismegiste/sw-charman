<content-stat>
    <div class="pure-u-1-1 pure-u-md-1-2" id="pc-view">
        <form class="pure-form pure-g" onchange="{ updateModel }">
            <div class="pure-u-1-4"><label>Name</label></div>
            <div class="pure-u-3-4"><input class="pure-input-1" type="text" name="name" value="{model.current.name}" required="true"/></div>
            <div class="pure-u-1-4"><label>Target</label></div>
            <div class="pure-u-3-4">
                <select class="pure-input-1" name="target" value="{model.current.target}">
                    <option value=""></option>
                    <option each="{model.characterList}" value="{name}">{name}</option>
                </select>
            </div>
            <div class="pure-u-1-4"><label>Attack</label></div>
            <div class="pure-u-1-4">
                <select name="attack" value="{model.current.attack}">
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
                    <input type="checkbox" name="shaken" checked="{ model.current.shaken }"/>
                </label>
            </div>
            <div class="pure-u-1-4"><label>Damage</label></div>
            <div class="pure-u-3-4">
                <input type="text" name="damage" value="{ model.current.damage }" class="pure-input-1"/>
            </div>
            <div class="pure-u-1-4"><label>To Hit</label></div>
            <div class="pure-u-1-4"><input type="number" value="{model.current.toHit}" name="toHit" class="pure-input-2-3"/></div>
            <div class="pure-u-1-4"><label>Toughness</label></div>
            <div class="pure-u-1-4"><input type="number" value="{model.current.toughness}" name="toughness" class="pure-input-2-3"/></div>
            <div class="pure-u-1-4"><label>Wounds</label></div>
            <div class="pure-u-1-4">
                <select name="wounds" value="{model.current.currentWounds}">
                    <option value="0">0</option>
                    <option value="-1">-1</option>
                    <option value="-2">-2</option>
                    <option value="-3">-3</option>
                    <option value="-4">Crit.</option>
                </select>
            </div>
            <div class="pure-u-1-4"><label>Token</label></div>
            <div class="pure-u-1-4">
                <select name="token" value="{model.current.spentToken}" max="{model.current.getMaxToken()}" riot-tag="token-select">
                </select>
            </div>
        </form>
        <footer class="pure-g button-spacing">
            <div class="pure-u-1-3"><a class="pure-button" onclick="{ onReset }">Reset</a></div>
            <div class="pure-u-1-3"><a class="pure-button pure-button-primary" onclick="{ onAppend }">Append</a></div>
            <div class="pure-u-1-3"><a class="pure-button button-error" onclick="{ onDelete }">Delete</a></div>
        </footer>
    </div>

    <script>
        this.mixin('toasty')
        this.mixin('model')
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
            // checking
            self.model.trigger('reset');
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

        updateModel() {
            self.updateCurrent();
            var idx = self.model.characterList.indexOf(self.model.current);
            if (idx !== -1) {
                self.model.characterList[idx] = self.model.current;
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
