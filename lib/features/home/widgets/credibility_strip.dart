import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class CredibilityStrip extends StatelessWidget {
  const CredibilityStrip({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final item in items)
              Chip(
                avatar: Icon(Icons.check_circle_outline, color: colors.accent),
                label: Text(item),
              ),
          ],
        ),
      ),
    );
  }
}
