import 'package:flutter/material.dart';

import '../../../core/widgets/scroll_reveal.dart';

class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          child: Text(eyebrow.toUpperCase(), style: textTheme.labelMedium),
        ),
        const SizedBox(height: 12),
        ScrollReveal(
          delay: const Duration(milliseconds: 80),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Text(title, style: textTheme.displayMedium),
          ),
        ),
        const SizedBox(height: 16),
        ScrollReveal(
          delay: const Duration(milliseconds: 160),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(description, style: textTheme.bodyLarge),
          ),
        ),
        const SizedBox(height: 32),
        child,
      ],
    );
  }
}
