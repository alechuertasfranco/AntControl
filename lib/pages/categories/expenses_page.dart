import 'package:flutter/material.dart';

class ConfigureExpenseCategoriesPage extends StatelessWidget {
  const ConfigureExpenseCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías de Gastos'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: const Center(
        child: Text('Aquí puedes configurar las categorías de gastos.'),
      ),
    );
  }
}
