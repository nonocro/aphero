import 'package:flutter/material.dart';
import 'package:aphero/theme/app_colors_extension.dart';
import 'package:aphero/features/shared/soldier_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
 runApp(
  const ProviderScope(child: Aphero()),
 );
}

class Aphero extends StatelessWidget {
  const Aphero({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AP Hero',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'chau philomene',
        extensions: const <ThemeExtension<dynamic>>[
          AppColorsExtension(
            background: Colors.black,
            containerBackground: Colors.white,
            accent: Colors.orange,
            accentLight: Color(0xFFFFE5CC),
            textDark: Colors.black,
            textLight: Colors.white,
          ),
        ],
      ),
      home: SoldierMenu(),
    );
  }
}
