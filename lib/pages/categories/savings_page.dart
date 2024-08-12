import 'package:flutter/material.dart';

class ConfigureSavingsCategoriesPage extends StatelessWidget {
  const ConfigureSavingsCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías de Ahorro'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: const Center(
        child: Text('Aquí puedes configurar las categorías de ahorro.'),
      ),
    );
  }
}
