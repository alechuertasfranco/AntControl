import 'package:ant_control/components/account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ant_control/config/theme.dart';
import 'package:ant_control/models/account.dart';
import 'package:ant_control/models/bank.dart';
import 'package:ant_control/models/currency.dart';
import 'package:ant_control/models/account_type.dart';
import 'package:ant_control/services/accounts_service.dart';
import 'package:ant_control/services/banks_service.dart';
import 'package:ant_control/services/currencies_service.dart';
import 'package:ant_control/services/account_types_service.dart';

class AccountsTab extends StatefulWidget {
  const AccountsTab({super.key});

  @override
  AccountsTabState createState() => AccountsTabState();
}

class AccountsTabState extends State<AccountsTab> {
  List<Account> _accounts = [];
  List<Bank> _banks = [];
  List<Currency> _currencies = [];
  List<AccountType> _accountTypes = [];

  final AccountsService _accountsService = AccountsService();
  final BanksService _banksService = BanksService();
  final CurrenciesService _currenciesService = CurrenciesService();
  final AccountTypesService _accountTypesService = AccountTypesService();

  @override
  void initState() {
    super.initState();
    _loadAccounts();
    _loadDropdownData();
  }

  Future<void> _loadAccounts() async {
    final accounts = await _accountsService.getAccounts();
    if (mounted) {
      setState(() {
        _accounts = accounts;
      });
    }
  }

  Future<void> _loadDropdownData() async {
    final banks = await _banksService.getBanks();
    final currencies = await _currenciesService.getCurrencies();
    final accountTypes = await _accountTypesService.getAccountTypes();

    if (mounted) {
      setState(() {
        _banks = banks;
        _currencies = currencies;
        _accountTypes = accountTypes;
      });
    }
  }

  Future<void> _addOrEditAccount({Account? account}) async {
    Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AccountDialog(
          account: account,
          banks: _banks,
          currencies: _currencies,
          accountTypes: _accountTypes,
        );
      },
    );

    if (result != null) {
      final String name = result['name']!;
      final Bank bank = result['bank']!;
      final Currency currency = result['currency']!;
      final AccountType accountType = result['accountType']!;

      if (account == null) {
        final newAccount = Account(
          name: name,
          bankId: bank.id!,
          accountTypeId: accountType.id!,
          currencyId: currency.id!,
        );
        final success = await _accountsService.addAccount(newAccount);
        if (success) {
          _loadAccounts();
          showScaffoldMessage(const Text('Cuenta agregada exitosamente'));
        } else {
          showScaffoldMessage(const Text('Error al agregar la cuenta'));
        }
      } else {
        final updatedAccount = account.copyWith(name: name, bankId: bank.id!, accountTypeId: accountType.id!, currencyId: currency.id!);
        final success = await _accountsService.updateAccount(updatedAccount);
        if (success) {
          _loadAccounts();
          showScaffoldMessage(const Text('Cuenta actualizada exitosamente'));
        } else {
          showScaffoldMessage(const Text('Error al actualizar la cuenta'));
        }
      }
    }
  }

  Future<void> _deleteAccount(Account account) async {
    bool confirmDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Eliminar cuenta',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: Text(
                '¿Estás seguro de que deseas eliminar esta cuenta?\nEsta acción no se puede deshacer.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('Eliminar'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirmDelete) {
      final success = await _accountsService.deleteAccount(account.id);
      if (success) {
        _loadAccounts();
        showScaffoldMessage(const Text('Cuenta eliminada exitosamente'));
      } else {
        showScaffoldMessage(const Text('Error al eliminar la cuenta'));
      }
    }
  }

  void showScaffoldMessage(Text text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Rebuilding AccountsTab");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _accounts.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    itemCount: _accounts.length,
                    itemBuilder: (context, index) {
                      final account = _accounts[index];
                      return ListTile(
                        leading: const Icon(
                          Icons.account_balance,
                          size: 24.0,
                          color: AppColors.primary,
                        ),
                        title: Text(account.name, style: Theme.of(context).textTheme.bodyMedium),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: AppColors.primary, size: 20),
                              onPressed: () {
                                _addOrEditAccount(account: account);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                              onPressed: () {
                                _deleteAccount(account);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(child: Text('No hay cuentas registradas.')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, color: AppColors.text),
              label: Text(
                'Registrar una nueva cuenta',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onPressed: () {
                _addOrEditAccount();
              },
            ),
          ),
        ],
      ),
    );
  }
}
