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

3.  **Triggerek**
    * `Triggers/ID insert triggers.sql`
        *(ID feltöltés adat INSERT-nél.)*
    * `Triggers/Calculate rental fee when car was returned.sql`
        *(Automatikus bérlési költség kiszámítása és INSERT-álása a táblába.)*

4.  **Táblák feltöltése adatokkal**
    * `Tables/Data insert into tables.sql`
        *(Ez a fájl tartalmazza az INSERT utasításokat a táblák dummy adatokkal való feltöltéséhez.)*

5.  **Nézetek (Views)**
    * `Views/List available cars.sql`
        *(Lekérdezéseket segítő nézet.)*

3.  **Objektumok és Típusok**
    * `Objects/Car.sql`
    * `Objects/List cars by category dynamic.sql`

5.  **Csomagok (Packages)**
    * `Packages/Exceptions/Exceptions.sql`
    * `Packages/Error log/Error_log.sql`
    * `Packages/Error log/Error log package body.sql`

    * `Packages/Rentals/Rentals.sql`
    * `Packages/Rentals/Rentals package body.sql`

7.  **Tesztek**
    * `Tests/Add new rental.tst`
        *(Új autóbérlés autó ID, bérlés kezdeti ideje és bérlés vég ideje megadása alapján.)*
    * `Tests/Calculate rental fees.tst`
        *(Autóbérlés befejezése után automatikus végösszeg számítása és beszúrása a táblázatba.)*
    * `Tests/List cars by category (with dynamic querry).tst`
        *(Elérhető státuszú autók listázása dinamikus querry használatával autó kategória megadása alapján.)*
    * `Tests/List cars by category (with list).tst`
        *(Elérhető státuszú autók listázása lista segítségével dbms_outputra autó kategória megadása alapján.)*
    * `Tests/Return car.tst`
        *(Autóbérlés befejezése autó ID megadása alapján.)*

---

## 🛠️ Használt technológiák
* **Adatbázis:** Oracle Database
* **Nyelv:** PL/SQL
* **Eszközök:** SQL Developer / Datagrip