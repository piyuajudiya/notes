import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper{
   Future<Database> opendb()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
    'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, subtitle TEXT)');
    await db.execute(
        'CREATE TABLE fav (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, subtitle TEXT)');
    });
    return database;
  }
}

