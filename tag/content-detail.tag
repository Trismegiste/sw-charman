<content-detail class="pure-g">
    <header class="{ blockStyle }">
        <form class="pure-form pure-g">
            <legend class="pure-u-1">Template</legend>
            <div class="pure-u-1">
                <select name="type" value="{ model.current.type }" class="pure-input-1" onchange="{
                            onChange
                        }">
                    <option value="virtual"></option>
                    <option each="{key, type in builder.getTemplate()}" value="{key}">{type.title}</option>
                </select>
            </div>
            <div class="pure-u-1">
                <label>
                    <input type="checkbox" name="wildcard" checked="{ model.current.wildCard }"  onclick="{
                                onWildCard
                            }"/>
                    Wild Card
                </label>
            </div>
        </form>
    </header>
    <section class="{ blockStyle }">
        <!-- magic essence -->
        <pentacle if="{ model.current.type == 'nephilim' }"></pentacle>
        <unique-ka if="{ model.current.type == 'effetdragon' }"></unique-ka>
        <unique-ka if="{ model.current.type == 'kabbale' }" mode="5"></unique-ka>
        <unique-ka if="{ model.current.type == 'humain' }"
                   title="Initiation" ka="soleil"></unique-ka>
    </section>
    <!-- attributes -->
    <attribut if="{ model.current.type != 'nephilim' }" class="{ blockStyle }"></attribut>
    <!-- handicaps / chutes -->
    <handicap filter="nephilim" title="Chutes" if="{ model.current.type == 'nephilim' }" class="{ blockStyle }"></handicap>
    <handicap filter="humain" if="{ model.current.type == 'humain' }" class="{ blockStyle }"></handicap>
    <!-- comp -->
    <competence class="{ blockStyle }"></competence>
    <!-- atouts -->
    <section class="{ blockStyle }">
        <atout filter="general humain" if="{ model.current.type == 'humain' }"></atout>
        <atout filter="nephilim humain general antediluvien" if="{ model.current.type == 'nephilim' }"></atout>
        <atout filter="monstre humain general"
               if="{ ['kabbale', 'effetdragon', 'construct'].indexOf(model.current.type) != -1 }"></atout>
    </section>
    <!-- simulacre -->
    <section if="{ model.current.type == 'nephilim' }" class="{ blockStyle }">
        <unique-ka title="Simulacre" ka="soleil"></unique-ka>
        <attribut></attribut>
        <handicap filter="humain" group="1" title="Handicaps simulacre"></handicap>
    </section>
    <competence if="{ model.current.type == 'nephilim' }"
                group="1" title="Compétences simulacre"
                class="{ blockStyle }"></competence>
    <atout if="{ model.current.type == 'nephilim' }"
           group="1" filter="general humain" title="Atouts simulacre"
           class="{ blockStyle }"></atout>
    <histoire-invisible if="{ model.current.type == 'nephilim' }"
                        class="{ blockStyle }"></histoire-invisible>
    <metamorphe if="{ model.current.type == 'nephilim' }"
                class="{ blockStyle }"></metamorphe>
    <add-info class="{ blockStyle }"></add-info>
    <div class="pure-u-1 button-spacing" if="{ SwCharman.cloudFolder.id }">
        <a class="pure-button button-success" onclick="{
                    storeToRepository
                }">Store to DB</a>
        <a class="pure-button button-error" onclick="{
                    deleteFromRepository
                }">Delete from DB</a>
    </div>
    <script>
        this.blockStyle = "webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"
        this.model = SwCharman.model
        this.builder = SwCharman.builder
        var self = this;

        this.onChange = function () {
            self.builder.build(self.type.value, self.model.current)
        }

        this.onWildCard = function () {
            self.model.current.wildCard = self.wildcard.checked
        }

        // store the current char into the Repository
        this.storeToRepository = function () {
            if (self.model.current.name != '') {
                var temp = self.model.clone(self.model.current);
                temp.restart();
                self.model.trigger('store-db', temp)
            }
        }

        // delete the current char into the Repository
        this.deleteFromRepository = function () {
            if (self.model.current.name != '') {
                var temp = self.model.clone(self.model.current);
                temp.restart();
                self.model.trigger('delete-db', temp)
            }
        }
    </script>
</content-detail>
