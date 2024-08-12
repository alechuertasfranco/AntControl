import 'package:sqflite/sqflite.dart';
import 'package:ant_control/database/database_helper.dart';

class BanksRepository {
  Future<List<Map<String, dynamic>>> getBanks() async {
    final db = await DatabaseHelper().database;
    final banks = await db.query('banks');
    return banks;
  }

  Future<bool> addBank(String name) async {
    final db = await DatabaseHelper().database;
    try {
      await db.insert(
        'banks',
        {'name': name},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBank(int? id, String name) async {
    final db = await DatabaseHelper().database;

    if (id == null) {
      return false;
    }

    final int count = await db.update(
      'banks',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );

    return count > 0;
  }

  Future<bool> deleteBank(int? id) async {
    final db = await DatabaseHelper().database;

    if (id == null) {
      return false;
    }

    final int count = await db.delete(
      'banks',
      where: 'id = ?',
      whereArgs: [id],
    );

    return count > 0;
  }
}
