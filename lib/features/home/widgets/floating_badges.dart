import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class FloatingBadges extends StatefulWidget {
  const FloatingBadges({super.key});

  @override
  State<FloatingBadges> createState() => _FloatingBadgesState();
}

class _FloatingBadgesState extends State<FloatingBadges>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final labelStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: colors.textMuted,
        );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value * math.pi * 2;
        return Stack(
          children: [
            _badge(
              'Flutter',
              FractionalOffset(
                0.04 + math.sin(t) * 0.015,
                0.10 + math.cos(t * 0.8) * 0.018,
              ),
              colors,
              labelStyle,
            ),
            _badge(
              'Firebase',
              FractionalOffset(
                0.58 + math.cos(t * 1.1) * 0.018,
                0.06 + math.sin(t * 0.9) * 0.015,
              ),
              colors,
              labelStyle,
            ),
            _badge(
              'Dart',
              FractionalOffset(
                0.65 + math.sin(t * 0.7 + 1.0) * 0.02,
                0.78 + math.cos(t * 0.85) * 0.018,
              ),
              colors,
              labelStyle,
            ),
            _badge(
              'REST',
              FractionalOffset(
                0.02 + math.cos(t * 0.9 + 2.0) * 0.015,
                0.68 + math.sin(t * 0.75) * 0.02,
              ),
              colors,
              labelStyle,
            ),
            _badge(
              'Clean Arch',
              FractionalOffset(
                0.30 + math.sin(t * 1.2 + 0.5) * 0.018,
                0.90 + math.cos(t * 0.65) * 0.015,
              ),
              colors,
              labelStyle,
            ),
          ],
        );
      },
    );
  }

  Widget _badge(
    String label,
    FractionalOffset alignment,
    AppColors colors,
    TextStyle? labelStyle,
  ) {
    return Align(
      alignment: alignment,
      child: Opacity(
        opacity: 0.60,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceSoft.withValues(alpha: 0.80),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: colors.border.withValues(alpha: 0.45)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(label, style: labelStyle),
          ),
        ),
      ),
    );
  }
}
