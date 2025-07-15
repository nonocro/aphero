import 'package:flutter/material.dart';

class JoustOfHorses extends StatelessWidget {
  const JoustOfHorses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joust of Secrets'),
      ),
      body: const Center(
        child: Text(
          'This is the Joust of Horses page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  } 
}