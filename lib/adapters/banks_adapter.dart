import 'package:ant_control/models/bank.dart';

class BanksAdapter {
  List<Bank> bankListAdapter(List<Map<String, dynamic>> banks) {
    return banks.map((map) => Bank.fromMap(map)).toList();
  }

  List<Bank> formatBankList(List<Bank> banks) {
    return banks.toList();
  }
}
