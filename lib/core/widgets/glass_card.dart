import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 28.0,
  });

  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: colors.border.withValues(alpha: 0.45)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.surface.withValues(alpha: 0.70),
            colors.surface.withValues(alpha: 0.45),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colors.background.withValues(alpha: 0.25),
            blurRadius: 48,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: child,
    );
  }
}
