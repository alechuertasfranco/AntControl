import 'package:ant_control/config/theme.dart';
import 'package:flutter/material.dart';
import 'types_page.dart';
import 'accounts_page.dart';

class ConfigureAccountsPage extends StatelessWidget {
  const ConfigureAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cuentas Bancarias',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary050),
          ),
          iconTheme: const IconThemeData(color: AppColors.primary050),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.primary050),
            unselectedLabelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.secondary200),
            indicatorColor: AppColors.primary200,
            tabs: const [
              Tab(text: 'Cuentas Bancarias'),
              Tab(text: 'Tipos de Cuenta'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AccountsTab(),
            AccountTypesTab(),
          ],
        ),
      ),
    );
  }
}
