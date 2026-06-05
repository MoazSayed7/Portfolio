import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LocaleSwitch extends StatelessWidget {
  const LocaleSwitch({super.key});

  static const _english = Locale('en');
  static const _arabicEgypt = Locale('ar', 'EG');

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final current = context.locale;

    Widget option(Locale locale, String label) {
      final isSelected = current == locale;
      return GestureDetector(
        onTap: () => context.setLocale(locale),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? colors.accentSoft : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected
                  ? colors.accent.withValues(alpha: 0.22)
                  : colors.border,
            ),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isSelected ? colors.accent : colors.textPrimary,
            ),
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            option(_english, 'EN'),
            const SizedBox(width: 8),
            option(_arabicEgypt, 'AR-EG'),
          ],
        ),
      ),
    );
  }
}
