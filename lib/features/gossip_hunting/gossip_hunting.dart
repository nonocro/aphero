import 'package:flutter/material.dart';

class GossipHunting extends StatelessWidget {
  const GossipHunting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gossip Hunting'),
      ),
      body: const Center(
        child: Text(
          'This is the Gossip Hunting page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}