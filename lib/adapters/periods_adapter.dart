import 'package:ant_control/models/period.dart';
import 'package:ant_control/utils/format.dart';
import 'package:intl/intl.dart';

class PeriodsAdapter {
  List<Period> periodListAdapter(List<Map<String, dynamic>> periods) {
    return periods.map((map) => Period.fromMap(map)).toList();
  }

  Period formatPeriod(Period period) {
    final date = DateTime(period.year, period.month);
    final formattedDate = DateFormat('MMMM, yyyy', 'es').format(date).toCapitalized();
    return Period(id: period.id, month: period.month, year: period.year, formatted: formattedDate);
  }

  List<Period> formatPeriodList(List<Period> periods) {
    return periods.map((period) => formatPeriod(period)).toList();
  }
}
