import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class PeriodsRepository {
  Future<List<Map<String, dynamic>>> getPeriods() async {
    final db = await DatabaseHelper().database;
    final periods = await db.query('periods');
    return periods;
  }

  Future<bool> addPeriod(int year, int month) async {
    final db = await DatabaseHelper().database;

    try {
      await db.insert(
        'periods',
        {'year': year, 'month': month},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
