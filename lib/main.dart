import 'package:flutter/material.dart';
import 'package:aphero/features/shared/soldier_menu.dart';

class AppColors {
  static const background = Colors.black;
  static const containerBackground = Colors.white;
  static const accent = Colors.orange;
  static const accentLight = Color(0xFFFFE5CC);
  static const textDark = Colors.black;
  static const textLight = Colors.white;
}

void main() {
  runApp(MaterialApp(
    title: 'AP Hero',
    theme: ThemeData(
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'chau philomene',
    ),
    home: const SoldierMenu(),
  ));
}
