import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class PeriodsRepository {
  Future<List<Map<String, dynamic>>> getPeriods() async {
    final db = await DatabaseHelper().database;

    // Consulta a la tabla de periodos
    final periods = await db.query('periods');

    // Mostrar la información obtenida en el log
    if (kDebugMode) {
      print('Datos obtenidos del repositorio: $periods');
    }

    return periods;
  }

  Future<bool> addPeriod(int year, int month) async {
    final db = await DatabaseHelper().database;

    try {
      // Insertar un nuevo periodo
      await db.insert(
        'periods',
        {'year': year, 'month': month},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      // Retornar true si la operación fue exitosa
      return true;
    } catch (e) {
      // Mostrar error en el log
      if (kDebugMode) {
        print('Error al agregar el periodo: $e');
      }

      // Retornar false si ocurrió un error
      return false;
    }
  }
}
