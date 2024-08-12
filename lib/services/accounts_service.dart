import 'package:ant_control/models/account.dart';
import 'package:ant_control/adapters/accounts_adapter.dart';
import 'package:ant_control/repositories/accounts_repository.dart';

class AccountsService {
  final AccountsRepository _accountsRepository = AccountsRepository();
  final AccountsAdapter _accountsAdapter = AccountsAdapter();

  Future<List<Account>> getAccounts() async {
    final accounts = await _accountsRepository.getAccounts();
    return _accountsAdapter.accountListAdapter(accounts);
  }

  Future<bool> addAccount(Account account) async {
    final success = await _accountsRepository.addAccount(account);
    return success;
  }

  Future<bool> updateAccount(Account account) async {
    final success = await _accountsRepository.updateAccount(account);
    return success;
  }

  Future<bool> deleteAccount(int? id) async {
    final success = await _accountsRepository.deleteAccount(id);
    return success;
  }
}
