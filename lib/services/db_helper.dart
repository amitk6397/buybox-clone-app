import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final String TABLE_NAME;

  DBHelper({required this.TABLE_NAME});

  Database? myDb;

  Future<Database> getData() async {
    if (myDb != null) {
      return myDb!;
    } else {
      myDb = await openDb();
      return myDb!;
    }
  }

  Future<Database> openDb() async {
    final directory = await getApplicationDocumentsDirectory();
    String pathDb = join(directory.path, 'menu.db');

    // await deleteDatabase(pathDb);

    final db = await openDatabase(pathDb, version: 1);

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
      s_no INTEGER PRIMARY KEY AUTOINCREMENT,
      id TEXT UNIQUE,
      title TEXT,
      image TEXT,
      price TEXT,
      originPrice TEXT,
      unitCount TEXT,
      salesVolume TEXT
    )
  ''');

    return db;
  }

  Future<bool> addData({
    String? id,
    String? title,
    String? image,
    String? price,
    String? originPrice,
    String? unitCount,
    String? salesVolume,
  }) async {
    final db = await getData();

    int rowEffected = await db.insert(TABLE_NAME, {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'originPrice': originPrice,
      'unitCount': unitCount,
      'salesVolume': salesVolume,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);

    return rowEffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllData(String tableName) async {
    final db = await getData();

    List<Map<String, dynamic>> data = await db.query(tableName);

    return data;
  }

  Future<void> deleted(String tableName) async {
    final db = await getData();

    await db.delete(tableName);
  }
}
