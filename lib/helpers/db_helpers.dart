import 'package:sqflite/sqflite.dart' as sqli;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

//Helps to interact with the database : Data Layer
class DBHelper {
  //get database open & ready to use
  static Future<Database> getDatabase() async {
    final dbPath = await sqli.getDatabasesPath();
    //Either opens current database if found or create new one
    return await sqli.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  //Insert into table
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.getDatabase();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sqli.ConflictAlgorithm.replace,
    );
  }

  //Fetch from db table
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.getDatabase();
    return db.query(table);                //Equivalent to select * from Table
  }
}
