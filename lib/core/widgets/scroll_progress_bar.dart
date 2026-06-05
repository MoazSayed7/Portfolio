import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ScrollProgressBar extends StatefulWidget {
  const ScrollProgressBar({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<ScrollProgressBar> createState() => _ScrollProgressBarState();
}

class _ScrollProgressBarState extends State<ScrollProgressBar> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_update);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_update);
    super.dispose();
  }

  void _update() {
    final pos = widget.scrollController.position;
    if (pos.maxScrollExtent > 0) {
      final p = (pos.pixels / pos.maxScrollExtent).clamp(0.0, 1.0);
      if ((p - _progress).abs() > 0.001) {
        setState(() => _progress = p);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: _progress,
        child: Container(
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.accent, colors.accentSecondary],
            ),
          ),
        ),
      ),
    );
  }
}
