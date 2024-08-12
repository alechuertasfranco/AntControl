import 'package:ant_control/models/account.dart';

class AccountsAdapter {
  List<Account> accountListAdapter(List<Map<String, dynamic>> accounts) {
    return accounts.map((map) => Account.fromMap(map)).toList();
  }

  List<Account> formatAccountList(List<Account> accounts) {
    return accounts.toList();
  }
}
