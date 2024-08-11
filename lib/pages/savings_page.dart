import 'package:flutter/material.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ahorros'),
      ),
      body: const Center(
        child: Text('Página de Ahorros'),
      ),
    );
  }
}
