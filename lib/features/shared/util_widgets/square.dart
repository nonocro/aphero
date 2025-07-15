import 'package:aphero/features/shared/provider/game_settings_provider.dart';
import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Square extends ConsumerWidget {

  const Square({super.key,
    required this.icon,
    required this.color,
    required this.size,
    required this.destination,
    required this.gameName
  });

  final IconData icon;
  final Color color;
  final double size;
  final Widget destination;
  final String gameName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = context.appColors;

    return GestureDetector(
      onTap: () {
        ref.read(gameSettingsProvider.notifier).setGameName(gameName);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(
            icon,
            size: size * 0.8,
            color: appColors.textLight,
          ),
        ),
      ),
    );
  }
}