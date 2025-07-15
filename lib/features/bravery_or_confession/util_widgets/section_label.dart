import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Text(
      text,
      style: TextStyle(
        color: appColors.textLight,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }
}