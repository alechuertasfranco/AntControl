import 'package:ant_control/models/currency.dart';
import 'package:ant_control/adapters/currencies_adapter.dart';
import 'package:ant_control/repositories/currencies_repository.dart';

class CurrenciesService {
  final CurrenciesRepository _currenciesRepository = CurrenciesRepository();
  final CurrenciesAdapter _currenciesAdapter = CurrenciesAdapter();

  Future<List<Currency>> getCurrencies() async {
    final currencies = await _currenciesRepository.getCurrencies();
    return _currenciesAdapter.currencyListAdapter(currencies);
  }

  Future<bool> addCurrency(String name, String symbol) async {
    final success = await _currenciesRepository.addCurrency(name, symbol);
    return success;
  }

  Future<bool> updateCurrency(int? id, String name, String symbol) async {
    final success = await _currenciesRepository.updateCurrency(id, name, symbol);
    return success;
  }

  Future<bool> deleteCurrency(int? id) async {
    final success = await _currenciesRepository.deleteCurrency(id);
    return success;
  }
}
