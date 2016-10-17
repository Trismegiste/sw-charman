/*
 * Repository for Character
 */

var Repository = function () {
    this.cnx = new Dexie("sw-charman");
    this.cnx.version(1).stores({
        character: 'name'
    });

    this.cnx.open().catch(function (e) {
        alert("Open failed: " + e);
    });

    this.cnx.character.mapToClass(Character);
};

Repository.prototype.findByPk = function (pk) {
    return this.cnx.character.get(pk);
};

Repository.prototype.findAll = function () {
    return this.cnx.character.toArray();
};

Repository.prototype.persist = function (character) {
    this.cnx.character.put(character)
            .then(function (event) {
                console.log('success');
            })
            .catch(function (error) {
                console.log("Ooops: " + error);
            });
};
