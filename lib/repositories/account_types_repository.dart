import 'package:sqflite/sqflite.dart';
import 'package:ant_control/database/database_helper.dart';

class AccountTypesRepository {
  Future<List<Map<String, dynamic>>> getAccountTypes() async {
    final db = await DatabaseHelper().database;
    final accountTypes = await db.query('account_types');
    return accountTypes;
  }

  Future<bool> addAccountType(String name) async {
    final db = await DatabaseHelper().database;
    try {
      await db.insert(
        'account_types',
        {'name': name},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAccountType(int? id, String name) async {
    final db = await DatabaseHelper().database;

    if (id == null) {
      return false;
    }

    final int count = await db.update(
      'account_types',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );

    return count > 0;
  }

  Future<bool> deleteAccountType(int? id) async {
    final db = await DatabaseHelper().database;

    if (id == null) {
      return false;
    }

    final int count = await db.delete(
      'account_types',
      where: 'id = ?',
      whereArgs: [id],
    );

    return count > 0;
  }
}
