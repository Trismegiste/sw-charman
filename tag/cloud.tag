<cloud>
    <p>toto</p>
    <script>
        var self = this

        riot.route('/connected', function (name) {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })
    </script>
</cloud>