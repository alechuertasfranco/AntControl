import 'package:ant_control/models/account.dart';
import 'package:ant_control/models/account_type.dart';
import 'package:ant_control/models/bank.dart';
import 'package:ant_control/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:ant_control/components/text_field_component.dart';
import 'package:ant_control/components/dropdown_component.dart';

class AccountDialog extends StatefulWidget {
  final Account? account;
  final List<Bank> banks;
  final List<Currency> currencies;
  final List<AccountType> accountTypes;

  const AccountDialog({
    super.key,
    required this.account,
    required this.banks,
    required this.currencies,
    required this.accountTypes,
  });

  @override
  AccountDialogState createState() => AccountDialogState();
}

class AccountDialogState extends State<AccountDialog> {
  late TextEditingController _nameController;
  late Bank? _selectedBank;
  late Currency? _selectedCurrency;
  late AccountType? _selectedAccountType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.account?.name ?? '');
    _selectedBank = widget.account != null ? widget.banks.firstWhere((b) => b.id == widget.account!.bankId) : null;
    _selectedCurrency = widget.account != null ? widget.currencies.firstWhere((c) => c.id == widget.account!.currencyId) : null;
    _selectedAccountType = widget.account != null ? widget.accountTypes.firstWhere((at) => at.id == widget.account!.accountTypeId) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            width: constraints.maxWidth * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.account == null ? 'Registrar nueva cuenta' : 'Editar cuenta',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                buildTextField(
                  controller: _nameController,
                  labelText: 'Nombre de la cuenta',
                  labelStyle: Theme.of(context).textTheme.bodySmall!,
                  textStyle: Theme.of(context).textTheme.bodySmall!,
                ),
                const SizedBox(height: 16.0),
                buildDropdown<Bank>(
                  value: _selectedBank,
                  items: widget.banks,
                  hintText: 'Banco',
                  labelStyle: Theme.of(context).textTheme.bodySmall!,
                  textStyle: Theme.of(context).textTheme.bodySmall!,
                  itemLabelBuilder: (bank) => bank.name,
                  handleChange: (Bank? value) {
                    setState(() {
                      _selectedBank = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                buildDropdown<Currency>(
                  value: _selectedCurrency,
                  items: widget.currencies,
                  hintText: 'Divisa',
                  labelStyle: Theme.of(context).textTheme.bodySmall!,
                  textStyle: Theme.of(context).textTheme.bodySmall!,
                  itemLabelBuilder: (currency) => currency.name,
                  handleChange: (Currency? value) {
                    setState(() {
                      _selectedCurrency = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                buildDropdown<AccountType>(
                  value: _selectedAccountType,
                  items: widget.accountTypes,
                  hintText: 'Tipo de cuenta',
                  labelStyle: Theme.of(context).textTheme.bodySmall!,
                  textStyle: Theme.of(context).textTheme.bodySmall!,
                  itemLabelBuilder: (accountType) => accountType.name,
                  handleChange: (AccountType? value) {
                    setState(() {
                      _selectedAccountType = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('Cancelar', style: Theme.of(context).textTheme.labelMedium),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      child: Text('Guardar', style: Theme.of(context).textTheme.labelMedium),
                      onPressed: () {
                        final String name = _nameController.text.trim();
                        if (name.isNotEmpty && _selectedBank != null && _selectedCurrency != null && _selectedAccountType != null) {
                          Navigator.of(context).pop({
                            'name': name,
                            'bank': _selectedBank,
                            'currency': _selectedCurrency,
                            'accountType': _selectedAccountType,
                          });
                        } else {
                          showScaffoldMessage(const Text('Todos los campos deben ser seleccionados.'));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showScaffoldMessage(Text text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: text),
    );
  }
}
