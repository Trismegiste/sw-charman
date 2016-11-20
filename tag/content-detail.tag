<content-detail>
    <header>
        <form class="pure-form pure-g" onchange="{ onChange }">
            <legend class="pure-u-1">Template</legend>
            <div class="pure-u-1">
                <select name="type" value="{ model.type }" class="pure-input-1">
                    <option value=""></option>
                    <option each="{type in typeList}" value="{type.value}">{type.title}</option>
                </select>
            </div>
        </form>
    </header>
    <section>
        <pentacle></pentacle>
    </section>
    <section>
        <attribut></attribut>
    </section>
    <section>
        <unique-ka></unique-ka>
    </section>
    <section>
        <competence></competence>
    </section>
    <script>
        this.typeList = [
            {value: 'nephilim', title: 'Nephilim', build: function () {
                }
            },
            {value: 'effetdragon', title: 'Effet-dragon', build: function () {
                }
            },
            {value: 'kabbale', title: 'Créature de Kabbale', build: function () {
                }
            },
            {value: 'humain', title: 'Humain', build: function () {
                }
            }
        ]

        onChange() {
            // reset and init with build
            console.log(this.type.value)
        }
    </script>
</content-detail>
