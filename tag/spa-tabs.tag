<spa-tabs>
    <nav class="pure-menu pure-menu-horizontal top-menu">
        <ul class="pure-menu-list">
            <li each="{tab, i in menuTab}"
                class="pure-menu-item {pure-menu-selected: parent.isActiveTab(tab.ref)}">
                <a href="#{tab.ref}" class="pure-menu-link">
                    { tab.title }
                </a>
            </li>
        </ul>
    </nav>
    <div class="pure-g">
        <div class="pure-u-1-1 {hidden: !isActiveTab('list')}">
            <content-list></content-list>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('stat')}">
            <content-stat></content-stat>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('database')}">
            <content-database></content-database>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('detail')}">
            <content-detail></content-detail>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('dump')}">
            <dump-database></dump-database>
        </div>
    </div>
    <script>
        this.menuTab = [
            {ref: 'list', title: 'List'},
            {ref: 'stat', title: 'Stats'},
            {ref: 'detail', title: 'Detail'},
            {ref: 'database', title: 'DB'}
        ]
        this.activeTab = 'list'

        isActiveTab(ref) {
            return ref === this.activeTab
        }

        var subRoute = riot.route.create()
        var self = this
        this.menuTab.forEach(function(tab) {
            subRoute('/' + tab.ref, function() {
                self.activeTab = tab.ref
                self.update()
            })
        })
    </script>
</spa-tabs>