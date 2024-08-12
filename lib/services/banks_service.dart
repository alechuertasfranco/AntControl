import 'package:ant_control/adapters/banks_adapter.dart';
import 'package:ant_control/models/bank.dart';
import 'package:ant_control/repositories/banks_repository.dart';

class BanksService {
  final BanksRepository _banksRepository = BanksRepository();
  final BanksAdapter _banksAdapter = BanksAdapter();

  Future<List<Bank>> getBanks() async {
    final banks = await _banksRepository.getBanks();
    return _banksAdapter.bankListAdapter(banks);
  }

  Future<bool> addBank(String name) async {
    final success = await _banksRepository.addBank(name);
    return success;
  }

  Future<bool> updateBank(int? id, String name) async {
    final success = await _banksRepository.updateBank(id, name);
    return success;
  }

  Future<bool> deleteBank(int? id) async {
    final success = await _banksRepository.deleteBank(id);
    return success;
  }
}
