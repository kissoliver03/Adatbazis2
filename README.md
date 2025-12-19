# Car Manager - Adatbázis Dokumentáció

Ez a repository a **Car Manager** projekt adatbázis rétegét tartalmazza. A rendszer Oracle adatbázisra épül, és PL/SQL nyelven íródott.

## Telepítési útmutató

A szkriptek lefuttatásakor fontos a sorrend betartása a függőségek miatt (pl. nem hozhatsz létre triggert, amíg nincs kész a tábla).

### Futtatási sorrend

Az adatbázis felépítéséhez az alábbi sorrendben szükséges lefuttatni a fájlokat SQL Developer-ben.

1.  **Környezet előkészítése**
    * `Scripts/Car Manager.sql`
        *(Ez hozza létre a felhasználókat és az alap beállításokat.)*
    * `Scripts/Sequences.sql`
        *(Ez hozza létre a szekvenciákat.)*
        
2.  **Táblák létrehozása**
    * `Tables/Tables.sql`
        *(Ez a fájl tartalmazza a CREATE TABLE utasításokat.)*

3.  **Csomagok (Packages)**
    * `Packages/Error log/Error_log.sql`
    * `Packages/Error log/Error log package body.sql`

4.  **Triggerek**
    * `Triggers/ID insert triggers.sql`
        *(ID feltöltés adat INSERT-nél.)*
    * `Triggers/Calculate rental fee when car was returned.sql`
        *(Automatikus bérlési költség kiszámítása és INSERT-álása a táblába.)*

5.  **Táblák feltöltése adatokkal**
    * `Tables/Data insert into tables.sql`
        *(Ez a fájl tartalmazza az INSERT utasításokat a táblák dummy adatokkal való feltöltéséhez.)*

6.  **Nézetek (Views)**
    * `Views/List available cars.sql`
        *(Lekérdezéseket segítő nézet.)*
    * `Views/Customer statistics.sql`
        *(Vásárlói statisztika nézet.)*

7.  **Objektumok és Típusok**
    * `Objects/Car.sql`

8.  **Csomagok (Packages)**
    * `Packages/Exceptions/Exceptions.sql`

    * `Packages/Rentals/Rentals.sql`
    * `Packages/Rentals/Rentals package body.sql`

    * `Packages/Service/Service.sql`
    * `Packages/Service/Service package body.sql`

9.  **Tesztek**
    * `Tests/Add new rental.tst`
        *(Új autóbérlés autó ID, bérlés kezdeti ideje és bérlés vég ideje megadása alapján.)*
    * `Tests/List cars by category.tst`
        *(Elérhető státuszú autók listázása dinamikus querry használatával autó kategória megadása alapján.)*
    * `Tests/Return car.tst`
        *(Autóbérlés befejezése autó ID megadása alapján.)*
    * `Tests/Cancel reservation.tst`
        *(Autó foglalás visszamondása foglalási ID megadása alapján.)*
    * `Tests/Check car if its free for rental.tst`
        *(Autó megnézése, hogy szabad-e adott időintervallumra autó ID, kezdeti és vég időpont megadása alapján.)*
    * `Tests/Get all customers rentals summary.tst`
        *(Customerek bérlési statisztikái megnézése.)*
    * `Tests/get customer rental history.tst`
        *(Customer bérlési előzményei customer ID megadása alapján.)*
    * `Tests/Send car to service.tst`
        *(Autó szervízbe küldése.)*

---

## 🛠️ Használt technológiák
* **Adatbázis:** Oracle Database
* **Nyelv:** PL/SQL
* **Eszközök:** SQL Developer / Datagrip