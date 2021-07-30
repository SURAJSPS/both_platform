import 'dart:io';

import 'package:both_platform/datbase/data_model.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper.internal();

  static final DatabaseHelper instance = DatabaseHelper.internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDataBase();
    return _database;
  }

  initDataBase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'users_database.db');
    // ignore: unused_local_variable
    var userDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, image TEXT, phone TEXT, password TEXT)");
    // print("Table is created");
  }

  Future<void> insertUser(UserDataModel userDataModel) async {
    final db = await database;
    await db!.insert(
      'User',
      userDataModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    List usermatch = await db.query('User',);
    print(usermatch);
  }

// Future<void> isUser(String email,String password) async {
//     final db = await database;
//     await db!.
//     // List usermatch = await db.query('User',);
//     // print(usermatch);
  // }


}
