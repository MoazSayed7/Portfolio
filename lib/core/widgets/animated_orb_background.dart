import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AnimatedOrbBackground extends StatefulWidget {
  const AnimatedOrbBackground({super.key});

  @override
  State<AnimatedOrbBackground> createState() => _AnimatedOrbBackgroundState();
}

class _AnimatedOrbBackgroundState extends State<AnimatedOrbBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => CustomPaint(
        painter: _OrbPainter(value: _controller.value, colors: colors),
        size: Size.infinite,
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  const _OrbPainter({required this.value, required this.colors});

  final double value;
  final AppColors colors;

  @override
  void paint(Canvas canvas, Size size) {
    final t = value * math.pi * 2;

    _drawOrb(
      canvas,
      center: Offset(
        size.width * 0.15 + math.sin(t) * 60,
        size.height * 0.18 + math.cos(t * 0.7) * 40,
      ),
      radius: 350,
      color: colors.accent.withValues(alpha: 0.10),
    );

    _drawOrb(
      canvas,
      center: Offset(
        size.width * 0.88 + math.cos(t * 0.8) * 50,
        size.height * 0.14 + math.sin(t * 1.1) * 55,
      ),
      radius: 280,
      color: colors.accentSecondary.withValues(alpha: 0.08),
    );

    _drawOrb(
      canvas,
      center: Offset(
        size.width * 0.5 + math.sin(t * 0.6 + 1.2) * 80,
        size.height * 0.75 + math.cos(t * 0.9) * 45,
      ),
      radius: 320,
      color: colors.accent.withValues(alpha: 0.08),
    );
  }

  void _drawOrb(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required Color color,
  }) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_OrbPainter old) => old.value != value;
}
