import 'package:ant_control/models/account_type.dart';

class AccountTypesAdapter {
  List<AccountType> accountTypeListAdapter(List<Map<String, dynamic>> accountTypes) {
    return accountTypes.map((map) => AccountType.fromMap(map)).toList();
  }

  List<AccountType> formatAccountTypeList(List<AccountType> accountTypes) {
    return accountTypes.toList();
  }
}
