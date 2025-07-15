import 'package:flutter/material.dart';

class UnderBorder extends StatelessWidget {
  const UnderBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.orange,
            width: 5.0,
          ),
        ),
      ),
      child: const SizedBox(height: 10), // Adjust height as needed
    );
  }
}