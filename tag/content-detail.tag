<content-detail>
    <header>
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
    <!-- magic essence -->
    <section if="{ model.current.type == 'nephilim' }">
        <pentacle></pentacle>
    </section>
    <section if="{ model.current.type == 'effetdragon' || model.current.type == 'kabbale' }">
        <unique-ka value="4"></unique-ka>
    </section>
    <section if="{ model.current.type == 'humain' }">
        <unique-ka title="Initiation" ka="soleil" value="4"></unique-ka>
    </section>
    <!-- attributes -->
    <section if="{ model.current.type != 'nephilim' }">
        <attribut></attribut>
    </section>
    <!-- comp -->
    <section>
        <competence></competence>
    </section>
    <!-- handicaps & chutes -->
    <section if="{ model.current.type == 'nephilim' }">
        <handicap filter="nephilim" title="Chutes"></handicap>
    </section>
    <section if="{ model.current.type == 'humain' }">
        <handicap filter="humain"></handicap>
    </section>
    <!-- simulacre -->
    <section if="{ model.current.type == 'nephilim' }">
        <unique-ka title="Simulacre" ka="soleil" value="4"></unique-ka>
    </section>
    <section if="{ model.current.type == 'nephilim' }">
        <attribut></attribut>
    </section>
    <section if="{ model.current.type == 'nephilim' }">
        <competence group="1" title="Compétences simulacre"></competence>
    </section>
    <section if="{ model.current.type == 'nephilim' }">
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
