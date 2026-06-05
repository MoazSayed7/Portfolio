import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 18),
    this.duration = const Duration(milliseconds: 700),
    this.visibleFraction = 0.15,
  });

  final Widget child;
  final Duration delay;
  final Offset offset;
  final Duration duration;
  final double visibleFraction;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  late final Key _detectorKey;
  var _hasTriggered = false;
  var _visible = false;

  @override
  void initState() {
    super.initState();
    _detectorKey = UniqueKey();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasTriggered) return;
    if (info.visibleFraction >= widget.visibleFraction) {
      _hasTriggered = true;
      Future<void>.delayed(widget.delay, () {
        if (!mounted) return;
        setState(() => _visible = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: widget.duration,
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(
            _visible ? 0 : widget.offset.dx,
            _visible ? 0 : widget.offset.dy,
            0,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
