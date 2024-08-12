import 'package:flutter/material.dart';
import 'package:ant_control/config/theme.dart';
import 'package:ant_control/services/banks_service.dart';
import 'package:ant_control/models/bank.dart';

class ConfigureBanksPage extends StatefulWidget {
  const ConfigureBanksPage({super.key});

  @override
  ConfigureBanksPageState createState() => ConfigureBanksPageState();
}

class ConfigureBanksPageState extends State<ConfigureBanksPage> {
  List<Bank> _banks = [];
  final BanksService _banksService = BanksService();

  @override
  void initState() {
    super.initState();
    _loadBanks();
  }

  Future<void> _loadBanks() async {
    final banks = await _banksService.getBanks();
    if (mounted) {
      setState(() {
        _banks = banks;
      });
    }
  }

  Future<void> _addOrEditBank({Bank? bank}) async {
    String? bankName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController bankNameController = TextEditingController(text: bank?.name);
        return Dialog(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      bank == null ? 'Registrar nuevo banco' : 'Editar banco',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30.0),
                    TextField(
                      controller: bankNameController,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                        labelText: 'Nombre del banco',
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
                            final String name = bankNameController.text.trim();
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

    if (bankName != null && bankName.isNotEmpty) {
      final success = bank == null ? await _banksService.addBank(bankName) : await _banksService.updateBank(bank.id, bankName);
      if (success) {
        _loadBanks();
        showScaffoldMessage(Text(bank == null ? 'Banco agregado exitosamente' : 'Banco actualizado exitosamente'));
      } else {
        showScaffoldMessage(Text(bank == null ? 'Error al agregar el banco' : 'Error al actualizar el banco'));
      }
    }
  }

  Future<void> _deleteBank(Bank bank) async {
    bool confirmDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Eliminar banco',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: Text(
                '¿Estás seguro de que deseas eliminar este banco?\nEsta acción no se puede deshacer.',
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
      final success = await _banksService.deleteBank(bank.id);
      if (success) {
        _loadBanks();
        showScaffoldMessage(const Text('Banco eliminado exitosamente'));
      } else {
        showScaffoldMessage(const Text('Error al eliminar el banco'));
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
      appBar: AppBar(
        title: Text(
          'Bancos',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary050),
        ),
        iconTheme: const IconThemeData(color: AppColors.primary050),
      ),
      body: Column(
        children: [
          Expanded(
            child: _banks.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    itemCount: _banks.length,
                    itemBuilder: (context, index) {
                      final bank = _banks[index];
                      return ListTile(
                        leading: const Icon(
                          Icons.circle,
                          size: 10.0,
                          color: AppColors.primary,
                        ),
                        title: Text(bank.name, style: Theme.of(context).textTheme.bodyMedium),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.edit, color: AppColors.primary, size: 20),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                              onPressed: () {
                                _deleteBank(bank);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          _addOrEditBank(bank: bank);
                        },
                      );
                    },
                  )
                : const Center(child: Text('No hay bancos registrados.')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, color: AppColors.text),
              label: Text(
                'Registrar un nuevo banco',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onPressed: _addOrEditBank,
            ),
          ),
        ],
      ),
    );
  }
}
