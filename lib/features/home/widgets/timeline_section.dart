import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/layout/app_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/hover_lift.dart';
import '../../../core/widgets/scroll_reveal.dart';
import '../domain/timeline_entry.dart';
import 'section_shell.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key, required this.entries});

  final List<TimelineEntry> entries;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: 'Journey',
      title: 'From the classroom to production.',
      description:
          'A self-taught path that went from a computer programming diploma to shipping real Flutter apps — in under two years.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= AppBreakpoints.tablet;
          return isWide
              ? _WideTimeline(entries: entries)
              : _NarrowTimeline(entries: entries);
        },
      ),
    );
  }
}

// ─── Wide: animated center line with alternating left/right cards ─────────────

class _WideTimeline extends StatefulWidget {
  const _WideTimeline({required this.entries});

  final List<TimelineEntry> entries;

  @override
  State<_WideTimeline> createState() => _WideTimelineState();
}

class _WideTimelineState extends State<_WideTimeline>
    with SingleTickerProviderStateMixin {
  final _columnKey = GlobalKey();
  late final AnimationController _ctrl;
  late final Animation<double> _progress;
  bool _triggered = false;
  double _lineHeight = 0;

  // Distance from the top of the column to the centre of the first dot.
  // SizedBox(height:16) + half of 14px dot = 23px.
  static const double _firstDotOffset = 23.0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _progress = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.05) return;
    _triggered = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _columnKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !mounted) return;
      setState(() {
        _lineHeight = (box.size.height - _firstDotOffset * 2).clamp(
          0.0,
          double.maxFinite,
        );
      });
      _ctrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return VisibilityDetector(
      key: const Key('wide-timeline-line'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        // Unspecified horizontal position → centred by alignment.
        alignment: Alignment.topCenter,
        children: [
          // ── Animated gradient line (behind the rows) ──────────────────────
          Positioned(
            top: _firstDotOffset,
            child: AnimatedBuilder(
              animation: _progress,
              builder: (context, _) => Container(
                width: 2,
                height: _lineHeight * _progress.value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.accent.withValues(alpha: 0.85),
                      colors.accentSecondary.withValues(alpha: 0.65),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Rows (dots on top of the line) ────────────────────────────────
          Column(
            key: _columnKey,
            children: [
              for (var i = 0; i < widget.entries.length; i++)
                ScrollReveal(
                  delay: Duration(milliseconds: 100 * i),
                  offset: Offset(i.isEven ? -20 : 20, 0),
                  child: _WideRow(
                    entry: widget.entries[i],
                    isLeft: i.isEven,
                    isFirst: i == 0,
                    isLast: i == widget.entries.length - 1,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WideRow extends StatelessWidget {
  const _WideRow({
    required this.entry,
    required this.isLeft,
    required this.isFirst,
    required this.isLast,
  });

  final TimelineEntry entry;
  final bool isLeft;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final card = _TimelineCard(entry: entry);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left card slot
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 24, bottom: 28),
              child: isLeft
                  ? Align(alignment: Alignment.topRight, child: card)
                  : const SizedBox(),
            ),
          ),

          // Centre column: dot only (no line — the Stack draws it)
          SizedBox(
            width: 32,
            child: Column(
              children: [
                if (isFirst)
                  const SizedBox(height: 16)
                else
                  const Expanded(child: SizedBox()),
                _Dot(colors: colors),
                if (isLast)
                  const SizedBox(height: 16)
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),

          // Right card slot
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 28),
              child: !isLeft
                  ? Align(alignment: Alignment.topLeft, child: card)
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Narrow: animated left line with stacked cards ────────────────────────────

class _NarrowTimeline extends StatefulWidget {
  const _NarrowTimeline({required this.entries});

  final List<TimelineEntry> entries;

  @override
  State<_NarrowTimeline> createState() => _NarrowTimelineState();
}

class _NarrowTimelineState extends State<_NarrowTimeline>
    with SingleTickerProviderStateMixin {
  final _columnKey = GlobalKey();
  late final AnimationController _ctrl;
  late final Animation<double> _progress;
  bool _triggered = false;
  double _lineHeight = 0;

  // SizedBox(height:16) + half of 12px dot = 22px.
  static const double _firstDotOffset = 22.0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _progress = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.05) return;
    _triggered = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _columnKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !mounted) return;
      setState(() {
        _lineHeight = (box.size.height - _firstDotOffset * 2).clamp(
          0.0,
          double.maxFinite,
        );
      });
      _ctrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return VisibilityDetector(
      key: const Key('narrow-timeline-line'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          // ── Animated gradient line (left side, behind rows) ───────────────
          Positioned(
            // 11 = centre of 24px dot column (12) − 1px (half 2px line)
            left: 11,
            top: _firstDotOffset,
            child: AnimatedBuilder(
              animation: _progress,
              builder: (context, _) => Container(
                width: 2,
                height: _lineHeight * _progress.value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.accent.withValues(alpha: 0.85),
                      colors.accentSecondary.withValues(alpha: 0.65),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Rows ──────────────────────────────────────────────────────────
          Column(
            key: _columnKey,
            children: [
              for (var i = 0; i < widget.entries.length; i++)
                ScrollReveal(
                  delay: Duration(milliseconds: 100 * i),
                  child: _NarrowRow(
                    entry: widget.entries[i],
                    isFirst: i == 0,
                    isLast: i == widget.entries.length - 1,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NarrowRow extends StatelessWidget {
  const _NarrowRow({
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  final TimelineEntry entry;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: dot only (no line — the Stack draws it)
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 16),
                _Dot(colors: colors, size: 12),
                if (!isLast)
                  const Expanded(child: SizedBox())
                else
                  const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: _TimelineCard(entry: entry),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared widgets ───────────────────────────────────────────────────────────

class _Dot extends StatelessWidget {
  const _Dot({required this.colors, this.size = 14});

  final AppColors colors;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.accentSoft,
        border: Border.all(color: colors.accent, width: 2),
        boxShadow: [
          BoxShadow(
            color: colors.accent.withValues(alpha: 0.35),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.entry});

  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return HoverLift(
      glowColor: colors.accent,
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.date,
                style: textTheme.labelMedium?.copyWith(color: colors.accent),
              ),
              const SizedBox(height: 8),
              Text(entry.title, style: textTheme.titleLarge),
              const SizedBox(height: 10),
              Text(entry.description, style: textTheme.bodyMedium),
              if (entry.tags.isNotEmpty) ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: entry.tags
                      .map((tag) => Chip(label: Text(tag)))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
