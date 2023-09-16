import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
import "dart:async";



class SqlDb {

  static Database? _db;

  FutureOr<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initialDb();
      return _db!;
    }
  }

  FutureOr<Database> initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wisam.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("onUpgrade ==========================");
  }

  _onCreate(Database db , int version) async {
    await db.execute('''
      CREATE TABLE "tasks" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "name" TEXT,
        "description" TEXT
      )
    ''');
    print("onCreate DATABASE AND TABLE =============");
  }

  readData(String sql) async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async{
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}

