import 'package:my_new_orange/classes/database/database_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../header/utils/Utils.dart';
// import 'model.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, '$databaseTableName.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $databaseTableName(id INTEGER PRIMARY KEY , categoryId TEXT NOT NULL, categoryName TEXT NOT NULL,categoryImage TEXT NOT NULL,timeStamp TEXT NOT NULL,totalItem TEXT NOT NULL)",
        );
      },
    );
  }

  // insert data
  Future<int> insertPlanets(List<Planets> planets) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var planet in planets) {
      result = await db.insert(databaseTableName, planet.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  // retrieve data
  Future<List<Planets>> retrievePlanets() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
        await db.query(databaseTableName);
    return queryResult.map((e) => Planets.fromMap(e)).toList();
  }

  // retrieve data by ID
  Future<List<Planets>> retrievePlanetsById(int id) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
        await db.query(databaseTableName, where: 'id = ?', whereArgs: [id]);
    return queryResult.map((e) => Planets.fromMap(e)).toList();
  }

  // delete user
  Future<void> deletePlanet(int id) async {
    final db = await initializedDB();
    await db.delete(
      databaseTableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
