import 'package:ant_control/models/account_type.dart';
import 'package:ant_control/adapters/account_types_adapter.dart';
import 'package:ant_control/repositories/account_types_repository.dart';

class AccountTypesService {
  final AccountTypesRepository _accountTypesRepository = AccountTypesRepository();
  final AccountTypesAdapter _accountTypesAdapter = AccountTypesAdapter();

  Future<List<AccountType>> getAccountTypes() async {
    final accountTypes = await _accountTypesRepository.getAccountTypes();
    return _accountTypesAdapter.accountTypeListAdapter(accountTypes);
  }

  Future<bool> addAccountType(String name) async {
    final success = await _accountTypesRepository.addAccountType(name);
    return success;
  }

  Future<bool> updateAccountType(int? id, String name) async {
    final success = await _accountTypesRepository.updateAccountType(id, name);
    return success;
  }

  Future<bool> deleteAccountType(int? id) async {
    final success = await _accountTypesRepository.deleteAccountType(id);
    return success;
  }
}
