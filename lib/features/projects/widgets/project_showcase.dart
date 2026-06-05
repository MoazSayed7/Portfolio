import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/layout/app_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/hover_lift.dart';
import '../domain/portfolio_project.dart';

class ProjectShowcase extends StatelessWidget {
  const ProjectShowcase({
    super.key,
    required this.project,
    required this.isReversed,
  });

  final PortfolioProject project;
  final bool isReversed;

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
        final visual = _ProjectVisual(project: project);
        final details = _ProjectDetails(project: project, onOpen: _open);

        return HoverLift(
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
                    children: isReversed
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
                  tr('common.in_progress'),
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
        Text(tr('projects_ui.core_highlights'), style: textTheme.titleMedium),
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
        Text(tr('projects_ui.tech_stack'), style: textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final tech in project.techStack) Chip(label: Text(tech)),
          ],
        ),
        const SizedBox(height: 18),
        Text(tr('projects_ui.what_i_built'), style: textTheme.titleMedium),
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
  const _ProjectVisual({required this.project});

  final PortfolioProject project;

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
                tr('projects_ui.snapshot'),
                style: textTheme.labelLarge?.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 70,
                      top: 0,
                      bottom: 48,
                      child: _PanelCard(
                        title: project.title,
                        accentColor: project.accentColor,
                        compact: false,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 40,
                      bottom: 92,
                      width: 146,
                      child: _PanelCard(
                        title: project.category,
                        accentColor: project.accentColor,
                        compact: true,
                      ),
                    ),
                    Positioned(
                      left: 18,
                      right: 18,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: colors.surface.withValues(alpha: 0.78),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: colors.border),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              project.imageAssets.isEmpty
                                  ? Icons.photo_library_outlined
                                  : Icons.image_outlined,
                              color: project.accentColor,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                project.imageAssets.isEmpty
                                    ? tr('projects_ui.placeholder')
                                    : tr(
                                        'projects_ui.screenshots_available',
                                        namedArgs: {
                                          'count':
                                              '${project.imageAssets.length}',
                                        },
                                      ),
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
      child: Padding(
        padding: EdgeInsets.all(compact ? 16 : 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine how many placeholder bars actually fit.
            // Fixed content: accent bar (6) + gap (14) + text estimate + gap (8)
            const fixedAboveBars = 6 + 14 + 8;
            final textLines = compact ? 2 : 2;
            final lineHeight = compact
                ? (textTheme.titleMedium?.fontSize ?? 18) * 1.4
                : (textTheme.titleLarge?.fontSize ?? 22) * 1.4;
            final estimatedTextHeight = textLines * lineHeight;
            final barHeight = compact ? 12.0 : 16.0;
            final barGap = 8.0;
            final available =
                constraints.maxHeight - fixedAboveBars - estimatedTextHeight;
            final maxBars = compact ? 3 : 4;
            // How many bars fit in the remaining space?
            final barCount = available > 0
                ? ((available / (barHeight + barGap)).floor()).clamp(0, maxBars)
                : 0;

            return ClipRect(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  width: compact ? 46 : 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.60),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  maxLines: textLines,
                  overflow: TextOverflow.ellipsis,
                  style:
                      compact ? textTheme.titleMedium : textTheme.titleLarge,
                ),
                if (barCount > 0) ...[
                  const Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      barCount,
                      (index) => Container(
                        margin: EdgeInsets.only(
                          bottom: index < barCount - 1 ? barGap : 0,
                        ),
                        height: barHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: index.isEven
                              ? accentColor.withValues(alpha: 0.12)
                              : colors.surfaceSoft,
                        ),
                      ),
                    ),
                  ),
                ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
