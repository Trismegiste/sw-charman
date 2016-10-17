/*
 * Repository for Character
 */

var Repository = function () {
    this.cnx = new Dexie("sw-charman");
    this.cnx.version(1).stores({
        character: '++id'
    });
    this.cnx.open().catch(function (e) {
        alert("Open failed: " + e);
    });
};

Repository.prototype.findByPk = function (pk) {
    return this.cnx.character.get(pk);
};

Repository.prototype.findAll = function () {

};

Repository.prototype.persist = function (character) {
    this.cnx.character.put(character).catch(function (error) {
        console.log("Ooops: " + error);
    });
};
