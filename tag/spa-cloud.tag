<spa-cloud>
    <nav class="pure-menu pure-menu-horizontal top-menu">
        <ul class="pure-menu-list">
            <li each="{tab, i in menuTab}"
                class="pure-menu-item {pure-menu-selected: parent.isActiveTab(tab.ref)}">
                <a href="#{tab.ref}" class="pure-menu-link">
                    <i class="{ tab.title }"></i>
                </a>
            </li>
        </ul>
    </nav>
    <div class="pure-g">
        <div class="pure-u-1-1 {hidden: !isActiveTab('import')}">
            <cloud-import></cloud-import>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('backup')}">
            <cloud-backup></cloud-backup>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('export')}">
            <cloud-export></cloud-export>
        </div>
    </div>
    <script>
        this.menuTab = [
            {ref: 'import', title: 'icon-download-cloud'},
            {ref: 'backup', title: 'icon-upload-cloud'},
            {ref: 'export', title: 'icon-zoom-in'}
        ]
        this.activeTab = 'backup'

        isActiveTab(ref) {
            return ref === this.activeTab
        }

        // this to hide waiting spinner
        cloudClient.on('connected', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
            self.trigger('update-database')
        })

        var subRoute = riot.route.create()
        var self = this
        this.menuTab.forEach(function(tab) {
            subRoute('/' + tab.ref, function() {
                self.activeTab = tab.ref
                self.update()
            })
        })
    </script>
</spa-cloud>