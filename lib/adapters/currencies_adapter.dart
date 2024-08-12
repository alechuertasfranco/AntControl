import 'package:ant_control/models/currency.dart';

class CurrenciesAdapter {
  List<Currency> currencyListAdapter(List<Map<String, dynamic>> currencies) {
    return currencies.map((map) => Currency.fromMap(map)).toList();
  }

  List<Currency> formatCurrencyList(List<Currency> currencies) {
    return currencies.toList();
  }
}
