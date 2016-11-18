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
        <div each="{tab, i in menuTab}" class="pure-u-1-1 {hidden: !parent.isActiveTab(tab.ref)}">
            { tab.title }
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('list')}">
            <content-list repo="{this.opts.repository}"></content-list>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('stat')}">
            <content-stat repo="{this.opts.repository}"></content-stat>
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