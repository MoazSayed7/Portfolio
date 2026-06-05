import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.backgroundAlt,
    required this.surface,
    required this.surfaceSoft,
    required this.accent,
    required this.accentSoft,
    required this.accentSecondary,
    required this.accentSecondarySoft,
    required this.gradientMintEnd,
    required this.textPrimary,
    required this.textMuted,
    required this.border,
  });

  const AppColors.dark()
    : background = const Color(0xFF141820),
      backgroundAlt = const Color(0xFF1A1F2C),
      surface = const Color(0xFF1E2433),
      surfaceSoft = const Color(0xFF252C3D),
      accent = const Color(0xFF8BBDF0),
      accentSoft = const Color(0xFF1C2740),
      accentSecondary = const Color(0xFFC9A0E8),
      accentSecondarySoft = const Color(0xFF2A2240),
      gradientMintEnd = const Color(0xFF6B9FD6),
      textPrimary = const Color(0xFFE8EAF0),
      textMuted = const Color(0xFF9CA3B8),
      border = const Color(0xFF2E3548);

  final Color background;
  final Color backgroundAlt;
  final Color surface;
  final Color surfaceSoft;
  final Color accent;
  final Color accentSoft;
  final Color accentSecondary;
  final Color accentSecondarySoft;
  final Color gradientMintEnd;
  final Color textPrimary;
  final Color textMuted;
  final Color border;

  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>() ?? const AppColors.dark();

  @override
  ThemeExtension<AppColors> copyWith({
    Color? background,
    Color? backgroundAlt,
    Color? surface,
    Color? surfaceSoft,
    Color? accent,
    Color? accentSoft,
    Color? accentSecondary,
    Color? accentSecondarySoft,
    Color? gradientMintEnd,
    Color? textPrimary,
    Color? textMuted,
    Color? border,
  }) {
    return AppColors(
      background: background ?? this.background,
      backgroundAlt: backgroundAlt ?? this.backgroundAlt,
      surface: surface ?? this.surface,
      surfaceSoft: surfaceSoft ?? this.surfaceSoft,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      accentSecondary: accentSecondary ?? this.accentSecondary,
      accentSecondarySoft: accentSecondarySoft ?? this.accentSecondarySoft,
      gradientMintEnd: gradientMintEnd ?? this.gradientMintEnd,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;

    return AppColors(
      background: Color.lerp(background, other.background, t) ?? background,
      backgroundAlt:
          Color.lerp(backgroundAlt, other.backgroundAlt, t) ?? backgroundAlt,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceSoft: Color.lerp(surfaceSoft, other.surfaceSoft, t) ?? surfaceSoft,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t) ?? accentSoft,
      accentSecondary:
          Color.lerp(accentSecondary, other.accentSecondary, t) ??
          accentSecondary,
      accentSecondarySoft:
          Color.lerp(accentSecondarySoft, other.accentSecondarySoft, t) ??
          accentSecondarySoft,
      gradientMintEnd:
          Color.lerp(gradientMintEnd, other.gradientMintEnd, t) ??
          gradientMintEnd,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textMuted: Color.lerp(textMuted, other.textMuted, t) ?? textMuted,
      border: Color.lerp(border, other.border, t) ?? border,
    );
  }
}
