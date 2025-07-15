import 'package:flutter/material.dart';

class JoustOfSecrets extends StatelessWidget {
  const JoustOfSecrets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joust of Secrets'),
      ),
      body: Center(
        child: Text(
          'This is the Joust of Secrets page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}