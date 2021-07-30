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
    List usermatch = await db.query(
      'User',
    );
    print(usermatch);
  }

  Future isUser(String email, String password) async {
    final db = await database;
    await db!.query("User",
        where: 'email=? AND password=?', whereArgs: [email, password]);
    print("usermatch");
    List usermatch = await db.query("User",
        where: 'email=? AND password=?', whereArgs: [email, password]);
    if (usermatch.length > 0) {
      print("${usermatch.toString()}");

      return usermatch;
    } else {
      print("User Not match");
      return [];
      
    }
  }

  Future isUserGetData(String email, String password) async {
    final db = await database;
    await db!.query("User",
        where: 'email=? AND password=?', whereArgs: [email, password]);
    print("usermatch");
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
