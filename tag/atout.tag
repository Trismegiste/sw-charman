<atout>
    <form class="pure-form pure-g">
        <legend class="pure-u-1">{ opts.title || 'Atouts' }</legend>
        <div class="pure-u-1">
            <select name="groupe" class="pure-input-1 capitalize" value="{ selectedGroup }" onchange="{
                        onChangeGroup
                    }">
                <option value="0">Filtrez un groupe...</option>
                <option each="{ race in filter }" value="{race}">{race}</option>
            </select>
            <select name="subgroup" class="pure-input-1" value="{ selectedSubgroup }" onchange="{
                        onChangeSubgroup
                    }">
                <option value="0">Filtrez un sous-groupe...</option>
                <option each="{ titre in subGroupList }" value="{titre}">{titre}</option>
            </select>
            <select name="atout" class="pure-input-1" onchange="{
                        onAppendAtout
                    }">
                <option value="0">Cliquez pour ajouter...</option>
                <option each="{ filteredAtoutList }" value="{titre}">{titre}</option>
            </select>
        </div>
        <virtual each="{ model.current.atout[group] }">
            <div class="pure-u-1-{ info == '1' ? '2' : '1' }">
                <label title="Prérequis : {prerequis} &#013;Détail : {descr}">
                    <input type='radio' name="selectedEdge"
                           checked="{checkedAtout == this}" onclick="{
                                       onCheckedEdge
                                   }"/>
                    {titre}
                </label>
            </div>
            <div class="pure-u-1-2" if="{ info == '1' }">
                <input name="atoutInfo" value="{detail}"
                       class="pure-input-1" onchange="{
                                   parent.onUpdateDetail
                               }"/>
            </div>
        </virtual>
        <div class="pure-u-1-3">
            <button class="pure-button" onclick="{
                        onMoveUp
                    }"><i class="icon-up-open"></i></button>
            <button class="pure-button" onclick="{
                        onMoveDown
                    }"><i class="icon-down-open"></i></button>
        </div>
        <div class="pure-u-1-3">
            <button class="pure-button button-error" onclick="{
                        onDelete
                    }"><i class="icon-trash-empty"></i></button>
        </div>
        <div class="pure-u-1-3"><label class="centered">XP { model.current.getXP(group) }</label></div>
    </form>
    <style>
        atout button {
            margin-top: 0.6em;
        }
    </style>
    <script>
        this.model = SwCharman.model
        this.group = opts.group || 0;
        this.checkedAtout = undefined;
        this.filter = opts.filter.split(" ")
        this.atoutList = SwCharman.table.get('atout')
        this.selectedGroup = 0
        this.selectedSubgroup = 0
        this.subGroupList = []
        this.filteredAtoutList = []
        var self = this;

        this.onChangeGroup = function () {
            self.selectedGroup = self.groupe.value
            self.selectedSubgroup = 0
            self.subGroupList = self.getSubgroupFor(self.selectedGroup)
            self.filteredAtoutList = []
        }

        this.onChangeSubgroup = function () {
            self.selectedSubgroup = self.subgroup.value
            self.filteredAtoutList = self.getAtoutListFor(self.selectedGroup, self.selectedSubgroup)
        }

        this.getSubgroupFor = function (group) {
            var result = []
            for (var idx in self.atoutList) {
                var atout = self.atoutList[idx]
                if ((atout.group === group) && (-1 === result.indexOf(atout.subgroup))) {
                    result.push(atout.subgroup)
                }
            }

            return result
        }

        this.getAtoutListFor = function (group, subgroup) {
            var result = []
            for (var idx in self.atoutList) {
                var atout = self.atoutList[idx]
                if ((atout.group === group) && (atout.subgroup === subgroup)) {
                    result.push(atout)
                }
            }

            return result
        }

        this.onAppendAtout = function (e) {
            for (var idx in self.filteredAtoutList) {
                var atout = self.filteredAtoutList[idx]
                if (atout.titre === e.target.value) {
                    var temp = self.model.clone(atout)
                    self.model.current.atout[self.group].push(temp)
                    e.target.value = 0;
                }
            }
        }

        this.onUpdateDetail = function (e) {
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(e.item)
            if (-1 !== idx) {
                tab[idx].detail = e.target.value
            }
        }

        this.onCheckedEdge = function (e) {
            self.checkedAtout = e.item;
        }

        this.onDelete = function (e) {
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(self.checkedAtout)
            if (-1 !== idx) {
                tab.splice(idx, 1)
            }
        }

        this.onMoveUp = function (e) {
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(self.checkedAtout)
            if (-1 !== idx) {
                if (idx > 0) {
                    var tmp = tab[idx - 1]
                    tab[idx - 1] = tab[idx]
                    tab[idx] = tmp;
                }
            }
        }

        this.onMoveDown = function (e) {
            var tab = self.model.current.atout[self.group];
            var idx = tab.indexOf(self.checkedAtout)
            if (-1 !== idx) {
                if (idx < (tab.length - 1)) {
                    var tmp = tab[idx + 1]
                    tab[idx + 1] = tab[idx]
                    tab[idx] = tmp
                }
            }
        }

        this.model.on('update-hindrance', function () {
            self.update()
        })

    </script>
</atout>