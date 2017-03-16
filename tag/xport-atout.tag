<xport-atout class="exported">
    <div  each="{race, listing in atout}">
        <h1>{race}</h1>
        <table class="pure-table pure-table-horizontal">
            <thead>
                <tr>
                    <th width="25%">titre</th>
                    <th width="25%">prérequis</th>
                    <th>description</th>
                </tr>
            </thead>
            <tbody>
                <tr each="{listing}" if="{enabled==1}">
                    <td>{titre}</td>
                    <td>{prerequis}</td>
                    <td>{descr}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <script>
        var self = this
        this.atout = Xport.table.get('atout')
    </script>
</xport-atout>