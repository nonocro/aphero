import 'package:flutter/material.dart';

class ArrowOfDestiny extends StatelessWidget {
  const ArrowOfDestiny({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrow of Destiny'),
      ),
      body: const Center(
        child: Text(
          'This is the Arrow of Destiny page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}