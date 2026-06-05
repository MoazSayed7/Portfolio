import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimateOnScroll extends StatefulWidget {
  const AnimateOnScroll({
    super.key,
    required this.child,
    required this.effects,
    this.delay = Duration.zero,
    this.visibleFraction = 0.15,
  });

  final Widget child;
  final List<Effect<dynamic>> effects;
  final Duration delay;
  final double visibleFraction;

  @override
  State<AnimateOnScroll> createState() => _AnimateOnScrollState();
}

class _AnimateOnScrollState extends State<AnimateOnScroll> {
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
      setState(() => _visible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: Animate(
        effects: widget.effects,
        delay: widget.delay,
        target: _visible ? 1.0 : 0.0,
        child: widget.child,
      ),
    );
  }
}
