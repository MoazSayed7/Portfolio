import 'package:flutter/material.dart';

class HoverLift extends StatefulWidget {
  const HoverLift({
    super.key,
    required this.child,
    this.scale = 1.01,
    this.offset = const Offset(0, -6),
    this.duration = const Duration(milliseconds: 180),
    this.glowColor,
  });

  final Widget child;
  final double scale;
  final Offset offset;
  final Duration duration;
  final Color? glowColor;

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final inner = MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? widget.scale : 1,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: widget.duration,
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(
            _hovered ? widget.offset.dx : 0,
            _hovered ? widget.offset.dy : 0,
            0,
          ),
          child: widget.child,
        ),
      ),
    );

    if (widget.glowColor == null) return inner;

    return AnimatedContainer(
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: widget.glowColor!.withValues(
              alpha: _hovered ? 0.15 : 0,
            ),
            blurRadius: 28,
          ),
        ],
      ),
      child: inner,
    );
  }
}
