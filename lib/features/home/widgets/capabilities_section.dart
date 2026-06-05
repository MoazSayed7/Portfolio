import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/hover_lift.dart';
import '../../../core/widgets/scroll_reveal.dart';
import '../../projects/domain/portfolio_project.dart';
import 'section_shell.dart';

class CapabilitiesSection extends StatelessWidget {
  const CapabilitiesSection({super.key, required this.groups});

  final List<CapabilityGroup> groups;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      eyebrow: tr('sections.capabilities.eyebrow'),
      title: tr('sections.capabilities.title'),
      description: tr('sections.capabilities.description'),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 20.0;
          final columns = constraints.maxWidth > 1100
              ? 4
              : constraints.maxWidth > 720
              ? 2
              : 1;
          final itemWidth = columns == 1
              ? constraints.maxWidth
              : (constraints.maxWidth - (spacing * (columns - 1))) / columns;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (var i = 0; i < groups.length; i++)
                ScrollReveal(
                  delay: Duration(milliseconds: 90 * i),
                  child: SizedBox(
                    width: itemWidth,
                    child: HoverLift(
                      glowColor: AppColors.of(context).accent,
                      child: _CapabilityCard(group: groups[i]),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CapabilityCard extends StatelessWidget {
  const _CapabilityCard({required this.group});

  final CapabilityGroup group;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.accentSoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(group.icon, color: colors.accent),
              ),
            ),
            const SizedBox(height: 18),
            Text(group.title, style: textTheme.titleLarge),
            const SizedBox(height: 14),
            for (final item in group.items)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_outward_rounded,
                      size: 16,
                      color: colors.accent,
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(item, style: textTheme.bodyMedium)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
