import 'package:sqflite/sqflite.dart';
import 'package:ant_control/database/database_helper.dart';
import 'package:ant_control/models/account.dart';

class AccountsRepository {
  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await DatabaseHelper().database;
    final accounts = await db.query('accounts');
    return accounts;
  }

  Future<bool> addAccount(Account account) async {
    final db = await DatabaseHelper().database;
    try {
      await db.insert(
        'accounts',
        account.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAccount(Account account) async {
    final db = await DatabaseHelper().database;

    final int count = await db.update(
      'accounts',
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.id],
    );

    return count > 0;
  }

  Future<bool> deleteAccount(int? id) async {
    final db = await DatabaseHelper().database;

    if (id == null) {
      return false;
    }

    final int count = await db.delete(
      'accounts',
      where: 'id = ?',
      whereArgs: [id],
    );

    return count > 0;
  }
}
