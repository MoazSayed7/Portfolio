import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/layout/app_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/hover_lift.dart';
import '../domain/portfolio_project.dart';

class ProjectShowcase extends StatefulWidget {
  const ProjectShowcase({
    super.key,
    required this.project,
    required this.isReversed,
  });

  final PortfolioProject project;
  final bool isReversed;

  @override
  State<ProjectShowcase> createState() => _ProjectShowcaseState();
}

class _ProjectShowcaseState extends State<ProjectShowcase> {
  bool _hovered = false;

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= AppBreakpoints.tablet;

        // Desktop only: reveal second phone on hover.
        // Narrow/touch: always one phone — no room and no hover on touch.
        final revealSecondary = isWide && _hovered;

        final visual = _ProjectVisual(
          project: widget.project,
          revealSecondary: revealSecondary,
        );
        final details = _ProjectDetails(project: widget.project, onOpen: _open);

        return MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: HoverLift(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.surface.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: colors.border),
                boxShadow: [
                  BoxShadow(
                    color: colors.background.withValues(alpha: 0.25),
                    blurRadius: 36,
                    offset: const Offset(0, 22),
                  ),
                ],
              ),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.isReversed
                          ? [
                              Expanded(child: details),
                              const SizedBox(width: 28),
                              Expanded(child: visual),
                            ]
                          : [
                              Expanded(child: visual),
                              const SizedBox(width: 28),
                              Expanded(child: details),
                            ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [visual, const SizedBox(height: 20), details],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _ProjectDetails extends StatelessWidget {
  const _ProjectDetails({required this.project, required this.onOpen});

  final PortfolioProject project;
  final Future<void> Function(String url) onOpen;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isInProgress = project.status == ProjectStatus.inProgress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(project.category.toUpperCase(), style: textTheme.labelMedium),
            if (isInProgress)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colors.accentSoft,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'In Progress',
                  style: textTheme.labelLarge?.copyWith(color: colors.accent),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(project.title, style: textTheme.headlineMedium),
        const SizedBox(height: 14),
        Text(project.summary, style: textTheme.bodyLarge),
        const SizedBox(height: 24),
        Text('Core highlights', style: textTheme.titleMedium),
        const SizedBox(height: 12),
        for (final feature in project.features)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: project.accentColor,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(feature, style: textTheme.bodyMedium)),
              ],
            ),
          ),
        const SizedBox(height: 18),
        Text('Tech stack', style: textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final tech in project.techStack) Chip(label: Text(tech)),
          ],
        ),
        const SizedBox(height: 18),
        Text('What I built', style: textTheme.titleMedium),
        const SizedBox(height: 10),
        Text(project.roleSummary, style: textTheme.bodyMedium),
        if (project.links.isNotEmpty) ...[
          const SizedBox(height: 22),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final link in project.links)
                OutlinedButton(
                  key: Key('${project.slug}_${link.id}'),
                  onPressed: () => onOpen(link.url),
                  child: Text(link.label),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ProjectVisual extends StatelessWidget {
  const _ProjectVisual({required this.project, required this.revealSecondary});

  final PortfolioProject project;
  final bool revealSecondary;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return AspectRatio(
      aspectRatio: 1.08,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: colors.border),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              project.accentColor.withValues(alpha: 0.18),
              colors.surface,
              colors.backgroundAlt,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project snapshot',
                style: textTheme.labelLarge?.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: project.imageAssets.isNotEmpty
                    ? _ScreenshotStack(
                        assets: project.imageAssets,
                        accentColor: project.accentColor,
                        colors: colors,
                        revealed: revealSecondary,
                      )
                    : _PlaceholderStack(
                        project: project,
                        colors: colors,
                        textTheme: textTheme,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Real screenshots ──────────────────────────────────────────────────────────

class _ScreenshotStack extends StatelessWidget {
  const _ScreenshotStack({
    required this.assets,
    required this.accentColor,
    required this.colors,
    required this.revealed,
  });

  final List<String> assets;
  final Color accentColor;
  final AppColors colors;
  final bool revealed;

  static const double _phoneAspect = 9 / 19.5;
  static const Duration _dur = Duration(milliseconds: 300);
  static const Curve _curve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;

        final primaryH = h * 0.84;
        final primaryW = primaryH * _phoneAspect;

        final secondaryH = h * 0.72;
        final secondaryW = secondaryH * _phoneAspect;

        final hasSecondary = assets.length >= 2;
        final showSecondary = revealed && hasSecondary;

        // ── Rest: primary alone, perfectly centered ──────────────────────────
        final primaryRestLeft = (w - primaryW) / 2;
        final primaryRestTop = (h - primaryH) / 2;

        // ── Revealed: both phones side-by-side, pair centered ────────────────
        final gap = w * 0.04;
        final totalPairW = primaryW + gap + secondaryW;
        final pairStartX = (w - totalPairW) / 2;

        final primaryRevealLeft = pairStartX;
        final primaryRevealTop = (h - primaryH) / 2;

        final secondaryRevealLeft = pairStartX + primaryW + gap;
        final secondaryRevealTop = (h - secondaryH) / 2 + h * 0.05;

        // ── Current animated values ──────────────────────────────────────────
        final primaryLeft = showSecondary ? primaryRevealLeft : primaryRestLeft;
        final primaryTop = showSecondary ? primaryRevealTop : primaryRestTop;
        final primaryTurns = showSecondary ? -0.012 : 0.0;

        // Secondary starts parked near the primary (invisible) and slides out
        final secondaryLeft = showSecondary
            ? secondaryRevealLeft
            : primaryRestLeft + primaryW * 0.4;
        final secondaryTop = showSecondary
            ? secondaryRevealTop
            : primaryRestTop + h * 0.06;

        return ClipRect(
          child: SizedBox(
            width: w,
            height: h,
            child: Stack(
              children: [
                // ── Secondary ── fades + slides in on hover ──────────────────
                if (hasSecondary)
                  AnimatedPositioned(
                    duration: _dur,
                    curve: _curve,
                    left: secondaryLeft,
                    top: secondaryTop,
                    width: secondaryW,
                    height: secondaryH,
                    child: AnimatedOpacity(
                      duration: _dur,
                      curve: _curve,
                      opacity: showSecondary ? 1.0 : 0.0,
                      child: AnimatedRotation(
                        duration: _dur,
                        curve: _curve,
                        turns: showSecondary ? 0.022 : 0.0,
                        child: _PhoneFrame(
                          asset: assets[1],
                          accentColor: accentColor,
                          colors: colors,
                        ),
                      ),
                    ),
                  ),

                // ── Primary ── shifts left + tilts on reveal ─────────────────
                AnimatedPositioned(
                  duration: _dur,
                  curve: _curve,
                  left: primaryLeft,
                  top: primaryTop,
                  width: primaryW,
                  height: primaryH,
                  child: AnimatedRotation(
                    duration: _dur,
                    curve: _curve,
                    turns: primaryTurns,
                    child: _PhoneFrame(
                      asset: assets[0],
                      accentColor: accentColor,
                      colors: colors,
                      isPrimary: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({
    required this.asset,
    required this.accentColor,
    required this.colors,
    this.isPrimary = false,
  });

  final String asset;
  final Color accentColor;
  final AppColors colors;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Scale all radii & chrome proportionally to the phone's actual width
        // so it looks like a real phone at any rendered size.
        final pw = constraints.maxWidth;
        final frameRadius = pw * 0.20; // ~20% of width → matches real phones
        final screenRadius = frameRadius - 5;
        final bezel = (pw * 0.045).clamp(4.0, 8.0);
        final islandW = (pw * 0.44).clamp(32.0, 56.0);
        final islandH = (pw * 0.10).clamp(8.0, 13.0);
        final islandBarH = (pw * 0.055).clamp(18.0, 26.0);
        final homeBarW = (pw * 0.38).clamp(28.0, 44.0);
        final homeBarH = (pw * 0.035).clamp(3.0, 4.0);
        final homeAreaH = (pw * 0.14).clamp(12.0, 18.0);

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111118),
            borderRadius: BorderRadius.circular(frameRadius),
            border: Border.all(
              color: isPrimary
                  ? accentColor.withValues(alpha: 0.55)
                  : colors.border.withValues(alpha: 0.50),
              width: isPrimary ? 1.8 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: isPrimary ? 0.28 : 0.08),
                blurRadius: isPrimary ? 40 : 20,
                spreadRadius: isPrimary ? 3 : 0,
                offset: const Offset(0, 14),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: isPrimary ? 0.50 : 0.35),
                blurRadius: isPrimary ? 28 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: EdgeInsets.all(bezel),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenRadius),
            child: Column(
              children: [
                // Dynamic island / camera pill
                Container(
                  height: islandBarH,
                  color: const Color(0xFF111118),
                  alignment: Alignment.center,
                  child: Container(
                    width: islandW,
                    height: islandH,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // Screenshot
                Expanded(
                  child: Image.asset(
                    asset,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                // Home indicator
                Container(
                  height: homeAreaH,
                  color: const Color(0xFF111118),
                  alignment: Alignment.center,
                  child: Container(
                    width: homeBarW,
                    height: homeBarH,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.20),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }, // LayoutBuilder builder
    );
  }
}

// ── Placeholder (no images yet) ───────────────────────────────────────────────

class _PlaceholderStack extends StatelessWidget {
  const _PlaceholderStack({
    required this.project,
    required this.colors,
    required this.textTheme,
  });

  final PortfolioProject project;
  final AppColors colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTight = constraints.maxHeight < 220;
        final sideCardWidth = (constraints.maxWidth * 0.44).clamp(118.0, 146.0);

        return Stack(
          children: [
            Positioned(
              left: 0,
              right: isTight ? sideCardWidth * 0.34 : 70,
              top: 0,
              bottom: isTight ? 56 : 48,
              child: _PanelCard(
                title: project.title,
                accentColor: project.accentColor,
                compact: false,
              ),
            ),
            Positioned(
              right: 0,
              top: isTight ? 26 : 40,
              bottom: isTight ? 58 : 92,
              width: sideCardWidth,
              child: _PanelCard(
                title: project.category,
                accentColor: project.accentColor,
                compact: true,
              ),
            ),
            Positioned(
              left: isTight ? 8 : 18,
              right: isTight ? 8 : 18,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(isTight ? 12 : 18),
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      color: project.accentColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Screenshot slots are ready for production captures.',
                        maxLines: isTight ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PanelCard extends StatelessWidget {
  const _PanelCard({
    required this.title,
    required this.accentColor,
    required this.compact,
  });

  final String title;
  final Color accentColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTight = constraints.maxHeight < 64;
          final padding = isTight
              ? 10.0
              : compact
              ? 14.0
              : 18.0;
          final titleStyle = isTight
              ? textTheme.bodyMedium
              : compact
              ? textTheme.titleMedium
              : textTheme.titleLarge;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isTight) ...[
                  Container(
                    width: compact ? 40 : 56,
                    height: 5,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.60),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                Flexible(
                  child: Text(
                    title,
                    maxLines: isTight
                        ? 1
                        : compact
                        ? 2
                        : 3,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
