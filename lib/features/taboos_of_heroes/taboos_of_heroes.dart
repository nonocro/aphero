import 'package:flutter/material.dart';

class TaboosOfHeroes extends StatelessWidget {
  const TaboosOfHeroes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taboos of Heroes'),
      ),
      body: const Center(
        child: Text(
          'This is the Taboos of Heroes page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}