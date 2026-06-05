import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

abstract final class AppTheme {
  static ThemeData dark() {
    const colors = AppColors.dark();
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(
      Typography.whiteMountainView,
    );

    TextStyle displayFont({
      required double size,
      required double height,
      required FontWeight weight,
      required Color color,
    }) {
      return GoogleFonts.spaceGrotesk().copyWith(
        fontSize: size,
        height: height,
        fontWeight: weight,
        color: color,
      );
    }

    final textTheme = baseTextTheme.copyWith(
      displayLarge: displayFont(
        size: 68,
        height: 0.95,
        weight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      displayMedium: displayFont(
        size: 48,
        height: 1.0,
        weight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      headlineMedium: displayFont(
        size: 32,
        height: 1.1,
        weight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      titleLarge: displayFont(
        size: 22,
        height: 1.15,
        weight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      titleMedium: displayFont(
        size: 18,
        height: 1.2,
        weight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.65,
        fontWeight: FontWeight.w500,
        color: colors.textMuted,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.65,
        fontWeight: FontWeight.w500,
        color: colors.textMuted,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: colors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        height: 1.25,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: colors.accent,
      ),
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.accent,
        brightness: Brightness.dark,
        surface: colors.surface,
        primary: colors.accent,
      ),
      textTheme: textTheme,
      extensions: const [colors],
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: colors.border),
        ),
      ),
      dividerColor: colors.border,
    );

    return base.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colors.background,
          backgroundColor: colors.accent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: textTheme.labelLarge,
          animationDuration: const Duration(milliseconds: 180),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.border),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: textTheme.labelLarge,
          animationDuration: const Duration(milliseconds: 180),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: colors.surfaceSoft,
        side: BorderSide(color: colors.border),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
    );
  }
}
