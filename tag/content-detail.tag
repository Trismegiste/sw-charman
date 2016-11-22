<content-detail>
    <header class="webcomponent">
        <form class="pure-form pure-g" onchange="{
                    onChange
                }">
            <legend class="pure-u-1">Template</legend>
            <div class="pure-u-1">
                <select name="type" value="{ model.current.type }" class="pure-input-1">
                    <option value=""></option>
                    <option each="{key, type in typeList}" value="{key}">{type.title}</option>
                </select>
            </div>
        </form>
    </header>
    <section class="webcomponent">
        <!-- magic essence -->
        <pentacle if="{ model.current.type == 'nephilim' }"></pentacle>
        <unique-ka if="{ model.current.type == 'effetdragon' || model.current.type == 'kabbale' }"
                   value="4"></unique-ka>
        <unique-ka if="{ model.current.type == 'humain' }"
                   title="Initiation" ka="soleil" value="4"></unique-ka>
    </section>
    <!-- attributes -->
    <attribut if="{ model.current.type != 'nephilim' }" class="webcomponent"></attribut>
    <!-- comp -->
    <competence class="webcomponent"></competence>
    <!-- handicaps / chutes -->
    <section class="webcomponent">
        <handicap filter="nephilim" title="Chutes" if="{ model.current.type == 'nephilim' }"></handicap>
        <handicap filter="humain" if="{ model.current.type == 'humain' }"></handicap>
    </section>
    <section if="{ model.current.type == 'nephilim' }" class="webcomponent">
        <!-- simulacre -->
        <unique-ka title="Simulacre" ka="soleil" value="4"></unique-ka>
        <attribut></attribut>
        <competence group="1" title="Compétences simulacre"></competence>
        <handicap filter="humain" group="1" title="Handicaps simulacre"></handicap>
    </section>
    <script>
        this.mixin('model')
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
            //self.trigger('reset');
            var newType = self.type.value
            self.model.current.type = newType
            self.typeList[newType].build(self.model.current)
        }
    </script>
</content-detail>
