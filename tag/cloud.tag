<cloud>
    <p>toto</p>
    <script>
        var self = this

        cloudClient.on('connected', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })
    </script>
</cloud>