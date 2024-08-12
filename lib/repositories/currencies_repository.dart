import 'package:sqflite/sqflite.dart';
import 'package:ant_control/database/database_helper.dart';

class CurrenciesRepository {
  Future<List<Map<String, dynamic>>> getCurrencies() async {
    final db = await DatabaseHelper().database;
    final currencies = await db.query('currencies');
    return currencies;
  }

  Future<bool> addCurrency(String name, String symbol) async {
    final db = await DatabaseHelper().database;
    try {
      await db.insert(
        'currencies',
        {'name': name, 'symbol': symbol},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCurrency(int? id, String name, String symbol) async {
    final db = await DatabaseHelper().database;

    if (id == null) {
      return false;
    }

    final int count = await db.update(
      'currencies',
      {'name': name, 'symbol': symbol},
      where: 'id = ?',
      whereArgs: [id],
    );

    return count > 0;
  }

  Future<bool> deleteCurrency(int? id) async {
    final db = await DatabaseHelper().database;

    if (id == null) {
      return false;
    }

    final int count = await db.delete(
      'currencies',
      where: 'id = ?',
      whereArgs: [id],
    );

    return count > 0;
  }
}
