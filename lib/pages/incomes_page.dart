import 'package:flutter/material.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresos'),
      ),
      body: const Center(
        child: Text('Página de Ingresos'),
      ),
    );
  }
}
