import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/RefreshToken.dart';

class RefreshTokenDB {
  static final RefreshTokenDB instance = RefreshTokenDB._init();

  static Database? _database;

  RefreshTokenDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('refreshToken.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute("DROP TABLE IF EXISTS $tableRefreshToken");
    await db.execute('''
CREATE TABLE $tableRefreshToken ( 
  ${RefreshTokenFields.id} $idType, 
  ${RefreshTokenFields.username} $textType,
  ${RefreshTokenFields.refreshToken} $textType
  )
''');
  }

  Future<RefreshToken?> create(RefreshToken user) async {
    final db = await _initDB('refreshToken.db');

    final id = await db.insert(tableRefreshToken, user.toJson());
    return user.copy(id: id);
  }

  Future<RefreshToken?> getRefreshToken(String id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableRefreshToken,
      columns: RefreshTokenFields.values,
      where: '${RefreshTokenFields.username} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RefreshToken.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<RefreshToken?> readRefreshToken() async {
    final db = await instance.database;
    if (db == null) return null;
    var result = await db.query(tableRefreshToken);
    print("REFRESHHHHHHHHHHHHHHHHHHHHHHHHH");
    print(result);
    return result.isEmpty ? null : RefreshToken.fromJson(result.first);
  }

  /*Future<User?> readUserByUsername(String id) async {
    var db = await instance.database;
    String path = await getDatabasesPath();
    debugPrint(path);
    var res = await db.rawQuery("SELECT * FROM user WHERE username = '$id'");
    debugPrint(res.toString());
    if (res.isNotEmpty) {
      return User.fromJson(res.first);
    }

    return null;
  }*/

  Future deleteTable() async {
    final db = await instance.database;
    db.rawQuery('DELETE FROM ${tableRefreshToken}');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
