import 'package:flutter/material.dart';

class ConfigureAccountsPage extends StatelessWidget {
  const ConfigureAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar Cuentas Bancarias'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: const Center(
        child: Text('Aquí puedes configurar las cuentas bancarias.'),
      ),
    );
  }
}
