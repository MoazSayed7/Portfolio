import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/layout/app_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/hover_lift.dart';
import '../../../core/widgets/locale_switch.dart';
import 'floating_badges.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.primaryLinks,
    required this.secondaryLinks,
  });

  final VoidCallback onViewProjects;
  final Map<String, String> primaryLinks;
  final Map<String, String> secondaryLinks;

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= AppBreakpoints.tablet;

          final badge = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.accentSoft,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: colors.accent.withValues(alpha: 0.20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Text(
                      tr('hero.badge'),
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.accent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const LocaleSwitch(),
            ],
          )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
              )
              .moveX(
                begin: -12,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
              );

          final name = Text(
            tr('hero.name'),
            style: textTheme.displayLarge?.copyWith(
              fontSize: isWide ? 88 : 62,
            ),
          )
              .animate(delay: const Duration(milliseconds: 100))
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
              )
              .moveY(
                begin: 16,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
              );

          final headline = ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              tr('hero.headline'),
              style: textTheme.headlineMedium?.copyWith(
                color: colors.textMuted,
                fontSize: isWide ? 28 : 24,
              ),
            ),
          )
              .animate(delay: const Duration(milliseconds: 200))
              .fadeIn(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
              )
              .moveY(
                begin: 16,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
              );

          final description = ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(tr('hero.description'), style: textTheme.bodyLarge),
          )
              .animate(delay: const Duration(milliseconds: 300))
              .fadeIn(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
              )
              .moveY(
                begin: 12,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
              );

          final buttons = Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              HoverLift(
                child: ElevatedButton(
                  key: const Key('hero_download_cv_button'),
                  onPressed: () => _open(primaryLinks['Download CV']!),
                  child: Text(tr('hero.cta_cv')),
                ),
              ),
              HoverLift(
                child: ElevatedButton(
                  key: const Key('hero_view_projects_button'),
                  onPressed: onViewProjects,
                  child: Text(tr('hero.cta_projects')),
                ),
              ),
              for (final entry in primaryLinks.entries)
                if (entry.key != 'Download CV')
                  HoverLift(
                    child: OutlinedButton(
                      onPressed: () => _open(entry.value),
                      child: Text(entry.key),
                    ),
                  ),
              for (final entry in secondaryLinks.entries)
                HoverLift(
                  child: OutlinedButton(
                    key: Key('hero_${entry.key.toLowerCase()}_button'),
                    onPressed: () => _open(entry.value),
                    child: Text(entry.key),
                  ),
                ),
            ],
          )
              .animate(delay: const Duration(milliseconds: 400))
              .fadeIn(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
              )
              .moveY(
                begin: 12,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
              );

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              badge,
              const SizedBox(height: 24),
              name,
              const SizedBox(height: 18),
              headline,
              const SizedBox(height: 24),
              description,
              const SizedBox(height: 32),
              buttons,
            ],
          );

          final visual = const _HeroVisual()
              .animate(delay: const Duration(milliseconds: 220))
              .fadeIn(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
              )
              .move(
                begin: const Offset(18, 18),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
              );

          if (!isWide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [content, const SizedBox(height: 32), visual],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 7, child: content),
              const SizedBox(width: 36),
              Expanded(flex: 5, child: visual),
            ],
          );
        },
      ),
    );
  }
}

class _HeroVisual extends StatefulWidget {
  const _HeroVisual();

  @override
  State<_HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<_HeroVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return AspectRatio(
      aspectRatio: 0.92,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.accent.withValues(alpha: 0.15),
                    colors.surface,
                    colors.surfaceSoft,
                  ],
                ),
                border: Border.all(color: colors.border),
                boxShadow: [
                  BoxShadow(
                    color: colors.accent.withValues(alpha: 0.12),
                    blurRadius: 60,
                    offset: const Offset(0, 26),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(child: const FloatingBadges()),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final wave = math.sin(_controller.value * math.pi * 2);
              final glowOpacity = 0.06 + (wave + 1) / 2 * 0.06;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        gradient: RadialGradient(
                          center: const Alignment(0.0, 0.3),
                          radius: 0.8,
                          colors: [
                            colors.accent.withValues(alpha: glowOpacity),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 24,
                    child: _MetricCard(
                      icon: Icons.layers_outlined,
                      title: tr('hero.visual.metric_one_title'),
                      value: tr('hero.visual.metric_one_value'),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 132 + (wave * 8),
                    child: const _PhoneMockup(
                      titleKey: 'hero.visual.mockup_one_title',
                      subtitleKey: 'hero.visual.mockup_one_subtitle',
                    ),
                  ),
                  Positioned(
                    right: 24,
                    top: 196 - (wave * 10),
                    child: const _PhoneMockup(
                      titleKey: 'hero.visual.mockup_two_title',
                      subtitleKey: 'hero.visual.mockup_two_subtitle',
                      compact: true,
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: _MetricCard(
                      icon: Icons.rocket_launch_outlined,
                      title: tr('hero.visual.metric_two_title'),
                      value: tr('hero.visual.metric_two_value'),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(icon, color: colors.accent),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(value, style: textTheme.titleMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  const _PhoneMockup({
    required this.titleKey,
    required this.subtitleKey,
    this.compact = false,
  });

  final String titleKey;
  final String subtitleKey;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: compact ? 150 : 180,
      height: compact ? 270 : 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: colors.backgroundAlt,
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.background.withValues(alpha: 0.30),
            blurRadius: 26,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 54,
                height: 6,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(tr(titleKey), style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(tr(subtitleKey), style: textTheme.bodyMedium),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: List.generate(
                  compact ? 4 : 5,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            colors.accent.withValues(
                              alpha: compact ? 0.08 : 0.12,
                            ),
                            colors.surfaceSoft,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
