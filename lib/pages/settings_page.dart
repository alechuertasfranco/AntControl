import 'package:ant_control/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:ant_control/pages/bank_accounts_page.dart';
import 'package:ant_control/pages/banks_page.dart';
import 'package:ant_control/pages/categories/expenses_page.dart';
import 'package:ant_control/pages/categories/incomes_page.dart';
import 'package:ant_control/pages/categories/savings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Configuraciones',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary050),
      )),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          // Configurar Bancos
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Bancos'),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigureBanksPage()),
              );
            },
          ),
          const Divider(thickness: 0.1),

          // Configurar Cuentas Bancarias
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('Cuentas Bancarias'),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigureAccountsPage()),
              );
            },
          ),
          const Divider(thickness: 0.1),

          // Categorías de Ingresos
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Categorías de Ingresos'),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigureIncomeCategoriesPage()),
              );
            },
          ),
          const Divider(thickness: 0.1),

          // Categorías de Ahorro
          ListTile(
            leading: const Icon(Icons.savings),
            title: const Text('Categorías de Ahorro'),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigureSavingsCategoriesPage()),
              );
            },
          ),
          const Divider(thickness: 0.1),

          // Categorías de Gastos
          ListTile(
            leading: const Icon(Icons.money_off),
            title: const Text('Categorías de Gastos'),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigureExpenseCategoriesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
