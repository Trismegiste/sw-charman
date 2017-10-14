<pdf-bestiaire>
    <form class="pure-form" if="{ready}">
        <button class="pure-button pure-button-primary">
            Generate
        </button>
    </form>
    <script>
        var self = this
        self.ready = false

        // init assets
        for (var idx in SwCharman.model.kaList) {
            var ka = SwCharman.model.kaList[idx]
            SwCharman.assetManager.append(ka, './img/' + ka + '.png')
        }
        for (var k = 0; k < 2; k++) {
            SwCharman.assetManager.append('puce-' + k, './img/puce-' + k + '.png')
        }

        SwCharman.assetManager.load().then(function () {
            self.ready = true
        })

    </script>
</pdf-bestiaire>