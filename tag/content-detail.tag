<content-detail class="pure-g">
    <header class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3">
        <form class="pure-form pure-g" onchange="{
                    onChange
                }">
            <legend class="pure-u-1">Template</legend>
            <div class="pure-u-1">
                <select name="type" value="{ model.current.type }" class="pure-input-1">
                    <option value="virtual"></option>
                    <option each="{key, type in typeList}" value="{key}">{type.title}</option>
                </select>
            </div>
        </form>
    </header>
    <section class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3">
        <!-- magic essence -->
        <pentacle if="{ model.current.type == 'nephilim' }"></pentacle>
        <unique-ka if="{ model.current.type == 'effetdragon' || model.current.type == 'kabbale' }"
                   value="4"></unique-ka>
        <unique-ka if="{ model.current.type == 'humain' }"
                   title="Initiation" ka="soleil" value="4"></unique-ka>
    </section>
    <!-- attributes -->
    <attribut if="{ model.current.type != 'nephilim' }" class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"></attribut>
    <!-- handicaps / chutes -->
    <handicap filter="nephilim" title="Chutes" if="{ model.current.type == 'nephilim' }" class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"></handicap>
    <handicap filter="humain" if="{ model.current.type == 'humain' }" class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"></handicap>
    <!-- comp -->
    <competence class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"></competence>
    <!-- atouts -->
    <section class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3">
        <atout filter="general humain" if="{ model.current.type == 'humain' }"></atout>
        <atout filter="nephilim humain general" if="{ model.current.type == 'nephilim' }"></atout>
        <atout filter="monstre humain general"
               if="{ ['kabbale', 'effetdragon'].indexOf(model.current.type) != -1 }"></atout>
    </section>
    <!-- simulacre -->
    <section if="{ model.current.type == 'nephilim' }" class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3">
        <unique-ka title="Simulacre" ka="soleil" value="4"></unique-ka>
        <attribut></attribut>
        <handicap filter="humain" group="1" title="Handicaps simulacre"></handicap>
    </section>
    <competence if="{ model.current.type == 'nephilim' }"
                group="1" title="Compétences simulacre"
                class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"></competence>
    <atout if="{ model.current.type == 'nephilim' }"
           group="1" filter="general humain" title="Atouts simulacre"
           class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"></atout>
    <histoire-invisible if="{ model.current.type == 'nephilim' }"
                        class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"></histoire-invisible>
    <metamorphe if="{ model.current.type == 'nephilim' }"
                        class="webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"></metamorphe>
    <script>
        this.model = SwCharman.model
        this.typeList = {
            nephilim: {title: 'Nephilim', build: function () {
                }
            },
            effetdragon: {title: 'Effet-dragon', build: function () {
                }
            },
            kabbale: {title: 'Créature de Kabbale', build: function () {
                }
            },
            humain: {title: 'Humain', build: function () {
                }
            }
        }
        var self = this;

        onChange() {
            var newType = self.type.value
            self.model.current.type = newType
            //self.typeList[newType].build(self.model.current)
        }
    </script>
</content-detail>
