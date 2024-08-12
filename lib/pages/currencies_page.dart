import 'package:flutter/material.dart';
import 'package:ant_control/config/theme.dart';
import 'package:ant_control/services/currencies_service.dart';
import 'package:ant_control/models/currency.dart';

class ConfigureCurrenciesPage extends StatefulWidget {
  const ConfigureCurrenciesPage({super.key});

  @override
  ConfigureCurrenciesPageState createState() => ConfigureCurrenciesPageState();
}

class ConfigureCurrenciesPageState extends State<ConfigureCurrenciesPage> {
  List<Currency> _currencies = [];
  final CurrenciesService _currenciesService = CurrenciesService();

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  Future<void> _loadCurrencies() async {
    final currencies = await _currenciesService.getCurrencies();
    if (mounted) {
      setState(() {
        _currencies = currencies;
      });
    }
  }

  Future<void> _addOrEditCurrency({Currency? currency}) async {
    Map<String, String>? result = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController(text: currency?.name);
        final TextEditingController symbolController = TextEditingController(text: currency?.symbol);
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
                      currency == null ? 'Registrar nueva divisa' : 'Editar divisa',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: nameController,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                        labelText: 'Nombre de la divisa',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: symbolController,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                        labelText: 'Símbolo de la divisa',
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
                            final String name = nameController.text.trim();
                            final String symbol = symbolController.text.trim();
                            if (name.isNotEmpty && symbol.isNotEmpty) {
                              Navigator.of(context).pop({'name': name, 'symbol': symbol});
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

    if (result != null) {
      final String name = result['name']!;
      final String symbol = result['symbol']!;
      if (currency == null) {
        final success = await _currenciesService.addCurrency(name, symbol);
        if (success) {
          _loadCurrencies();
          showScaffoldMessage(const Text('Divisa agregada exitosamente'));
        } else {
          showScaffoldMessage(const Text('Error al agregar la divisa'));
        }
      } else {
        final success = await _currenciesService.updateCurrency(currency.id, name, symbol);
        if (success) {
          _loadCurrencies();
          showScaffoldMessage(const Text('Divisa actualizada exitosamente'));
        } else {
          showScaffoldMessage(const Text('Error al actualizar la divisa'));
        }
      }
    }
  }

  Future<void> _deleteCurrency(Currency currency) async {
    bool confirmDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Eliminar divisa',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: Text(
                '¿Estás seguro de que deseas eliminar esta divisa?\nEsta acción no se puede deshacer.',
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
      final success = await _currenciesService.deleteCurrency(currency.id);
      if (success) {
        _loadCurrencies();
        showScaffoldMessage(const Text('Divisa eliminada exitosamente'));
      } else {
        showScaffoldMessage(const Text('Error al eliminar la divisa'));
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
          'Divisas',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary050),
        ),
        iconTheme: const IconThemeData(color: AppColors.primary050),
      ),
      body: Column(
        children: [
          Expanded(
            child: _currencies.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    itemCount: _currencies.length,
                    itemBuilder: (context, index) {
                      final currency = _currencies[index];
                      return ListTile(
                        leading: const Icon(
                          Icons.circle,
                          size: 10.0,
                          color: AppColors.primary,
                        ),
                        title: Text(currency.name, style: Theme.of(context).textTheme.bodyMedium),
                        subtitle: Text(currency.symbol, style: Theme.of(context).textTheme.bodySmall),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: AppColors.primary, size: 20),
                              onPressed: () {
                                _addOrEditCurrency(currency: currency);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                              onPressed: () {
                                _deleteCurrency(currency);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(child: Text('No hay divisas registradas.')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, color: AppColors.text),
              label: Text(
                'Registrar una nueva divisa',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onPressed: _addOrEditCurrency,
            ),
          ),
        ],
      ),
    );
  }
}
