import 'package:ant_control/adapters/periods_adapter.dart';
import 'package:ant_control/models/period.dart';
import 'package:ant_control/repositories/periods_repository.dart';

class PeriodsService {
  final PeriodsRepository _periodsRepository = PeriodsRepository();
  final PeriodsAdapter _periodsAdapter = PeriodsAdapter();

  Future<List<Period>> getPeriods() async {
    final periods = await _periodsRepository.getPeriods();
    return _periodsAdapter.periodListAdapter(periods);
  }

  Future<bool> addPeriod(int year, int month) async {
    final success = await _periodsRepository.addPeriod(year, month);
    return success;
  }
}
