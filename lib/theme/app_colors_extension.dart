import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.background,
    required this.containerBackground,
    required this.accent,
    required this.accentLight,
    required this.textDark,
    required this.textLight,
  });

  final Color background;
  final Color containerBackground;
  final Color accent;
  final Color accentLight;
  final Color textDark;
  final Color textLight;

  @override
  AppColorsExtension copyWith({
    Color? background,
    Color? containerBackground,
    Color? accent,
    Color? accentLight,
    Color? textDark,
    Color? textLight,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      containerBackground: containerBackground ?? this.containerBackground,
      accent: accent ?? this.accent,
      accentLight: accentLight ?? this.accentLight,
      textDark: textDark ?? this.textDark,
      textLight: textLight ?? this.textLight,
    );
  }

  @override
  AppColorsExtension lerp(covariant ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      containerBackground: Color.lerp(containerBackground, other.containerBackground, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      textDark: Color.lerp(textDark, other.textDark, t)!,
      textLight: Color.lerp(textLight, other.textLight, t)!,
    );
  }

  @override
  int get hashCode => Object.hash(
    background,
    containerBackground,
    accent,
    accentLight,
    textDark,
    textLight,
  );

  @override
  bool operator ==(covariant AppColorsExtension other) {
    if (identical(this, other)) return true;
    return other.background == background &&
        other.containerBackground == containerBackground &&
        other.accent == accent &&
        other.accentLight == accentLight &&
        other.textDark == textDark &&
        other.textLight == textLight;
  }
}

extension BuildContextAppColorsExtension on BuildContext {
  AppColorsExtension get appColors => Theme.of(this).extension<AppColorsExtension>()!;
}