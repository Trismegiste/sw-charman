<content-detail class="pure-g">
    <header class="{ blockStyle }">
        <form class="pure-form pure-g" onchange="{
                    onChange
                }">
            <legend class="pure-u-1">Template</legend>
            <div class="pure-u-1">
                <select name="type" value="{ model.current.type }" class="pure-input-1">
                    <option value="virtual"></option>
                    <option each="{key, type in builder.getTemplate()}" value="{key}">{type.title}</option>
                </select>
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
               if="{ ['kabbale', 'effetdragon'].indexOf(model.current.type) != -1 }"></atout>
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
    <script>
        this.blockStyle = "webcomponent pure-u-1 pure-u-md-1-2 pure-u-xl-1-3"
        this.model = SwCharman.model
        this.builder = SwCharman.builder
        var self = this;

        onChange() {
            self.builder.build(self.type.value, self.model.current)
        }
    </script>
</content-detail>
