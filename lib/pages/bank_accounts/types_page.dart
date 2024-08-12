import 'package:flutter/material.dart';
import 'package:ant_control/config/theme.dart';
import 'package:ant_control/models/account_type.dart';
import 'package:ant_control/services/account_types_service.dart';

class AccountTypesTab extends StatefulWidget {
  const AccountTypesTab({super.key});

  @override
  AccountTypesTabState createState() => AccountTypesTabState();
}

class AccountTypesTabState extends State<AccountTypesTab> {
  List<AccountType> _accountTypes = [];
  final AccountTypesService _accountTypesService = AccountTypesService();

  @override
  void initState() {
    super.initState();
    _loadAccountTypes();
  }

  Future<void> _loadAccountTypes() async {
    final accountTypes = await _accountTypesService.getAccountTypes();
    if (mounted) {
      setState(() {
        _accountTypes = accountTypes;
      });
    }
  }

  Future<void> _addOrEditAccountType({AccountType? accountType}) async {
    String? accountTypeName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController accountTypeNameController = TextEditingController(text: accountType?.name);
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
                      accountType == null ? 'Registrar nuevo tipo de cuenta' : 'Editar tipo de cuenta',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30.0),
                    TextField(
                      controller: accountTypeNameController,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                        labelText: 'Tipo de cuenta',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        border: const OutlineInputBorder(),
                      ),
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
                            final String name = accountTypeNameController.text.trim();
                            if (name.isNotEmpty) {
                              Navigator.of(context).pop(name);
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
      },
    );

    if (accountTypeName != null && accountTypeName.isNotEmpty) {
      final success =
          accountType == null ? await _accountTypesService.addAccountType(accountTypeName) : await _accountTypesService.updateAccountType(accountType.id, accountTypeName);
      if (success) {
        _loadAccountTypes();
        showScaffoldMessage(Text(accountType == null ? 'Tipo de cuenta agregado exitosamente' : 'Tipo de cuenta actualizado exitosamente'));
      } else {
        showScaffoldMessage(Text(accountType == null ? 'Error al agregar el tipo de cuenta' : 'Error al actualizar el tipo de cuenta'));
      }
    }
  }

  Future<void> _deleteAccountType(AccountType accountType) async {
    bool confirmDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Eliminar tipo de cuenta',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: Text(
                '¿Estás seguro de que deseas eliminar este tipo de cuenta?\nEsta acción no se puede deshacer.',
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
      final success = await _accountTypesService.deleteAccountType(accountType.id);
      if (success) {
        _loadAccountTypes();
        showScaffoldMessage(const Text('Tipo de cuenta eliminado exitosamente'));
      } else {
        showScaffoldMessage(const Text('Error al eliminar el tipo de cuenta'));
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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _accountTypes.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    itemCount: _accountTypes.length,
                    itemBuilder: (context, index) {
                      final accountType = _accountTypes[index];
                      return ListTile(
                        leading: const Icon(
                          Icons.circle,
                          size: 10.0,
                          color: AppColors.primary,
                        ),
                        title: Text(accountType.name, style: Theme.of(context).textTheme.bodyMedium),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: AppColors.primary, size: 20),
                              onPressed: () {
                                _addOrEditAccountType(accountType: accountType);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                              onPressed: () {
                                _deleteAccountType(accountType);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(child: Text('No hay tipos de cuenta registrados.')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, color: AppColors.text),
              label: Text(
                'Registrar un nuevo tipo de cuenta',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onPressed: _addOrEditAccountType,
            ),
          ),
        ],
      ),
    );
  }
}
