import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbhelper{

 Future<Database>creatdatabase()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE contactbook (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT, fav TEXT)');
        });
    return database;
  }
}