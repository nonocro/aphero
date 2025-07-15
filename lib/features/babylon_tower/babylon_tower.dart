import 'package:flutter/material.dart';

class BabylonTower extends StatelessWidget {
  const BabylonTower({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Babylon Tower'),
      ),
      body: const Center(
        child: Text(
          'This is the Babylon Tower page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}