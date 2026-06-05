import 'package:flutter/material.dart';

import '../../../core/content/app_links.dart';
import '../../../core/content/portfolio_content.dart';
import '../../../core/layout/app_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/animated_orb_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/hover_lift.dart';
import '../../../core/widgets/scroll_progress_bar.dart';
import '../../../core/widgets/scroll_reveal.dart';
import '../widgets/capabilities_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/credibility_strip.dart';
import '../widgets/hero_section.dart';
import '../widgets/section_shell.dart';
import '../widgets/timeline_section.dart';
import '../../projects/widgets/project_showcase.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToProjects() {
    final context = _projectsKey.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      alignment: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final projects = PortfolioContent.projects();
    final capabilities = PortfolioContent.capabilities();
    final credibilityPoints = PortfolioContent.credibilityPoints();
    final timeline = PortfolioContent.timeline();

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          const Positioned.fill(
            child: IgnorePointer(child: AnimatedOrbBackground()),
          ),
          const _BackgroundTexture(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 3,
            child: ScrollProgressBar(scrollController: _scrollController),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.contentMaxWidth,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeroSection(
                          onViewProjects: _scrollToProjects,
                          primaryLinks: const {
                            'Download CV': AppLinks.cv,
                            'GitHub': AppLinks.github,
                            'LinkedIn': AppLinks.linkedIn,
                          },
                          secondaryLinks: const {
                            'Email': AppLinks.email,
                            'WhatsApp': AppLinks.whatsapp,
                          },
                        ),
                        const SizedBox(height: 28),
                        ScrollReveal(
                          delay: const Duration(milliseconds: 420),
                          child: CredibilityStrip(items: credibilityPoints),
                        ),
                        const SizedBox(height: 72),
                        SectionShell(
                          key: _projectsKey,
                          eyebrow: 'Selected Work',
                          title:
                              'Products built for real users, real payments, and real operations.',
                          description:
                              'The strongest proof is production work. These four projects show how I approach subscriptions, commerce, healthcare ordering, EV charging, and high-volume business workflows in Flutter.',
                          child: Column(
                            children: [
                              for (var i = 0; i < projects.length; i++)
                                ScrollReveal(
                                  delay: Duration(milliseconds: 120 * i),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: i == 0 ? 0 : 28,
                                    ),
                                    child: ProjectShowcase(
                                      project: projects[i],
                                      isReversed: i.isOdd,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 72),
                        SectionShell(
                          eyebrow: 'About',
                          title:
                              'I focus on Flutter products that need more than polished screens.',
                          description:
                              'My work sits where product logic, operational clarity, and reliable engineering meet. I enjoy building apps with strong architecture, real-world integrations, bilingual UX, and flows that have to hold up outside demo mode.',
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isWide =
                                  constraints.maxWidth >= AppBreakpoints.tablet;
                              final first = HoverLift(
                                glowColor: colors.accent,
                                child: _AboutCard(
                                  title: 'How I work',
                                  body:
                                      'I care about structure, maintainable state, good UX, and delivery speed. I prefer systems that are easy to extend, not just easy to demo.',
                                ),
                              );
                              final second = HoverLift(
                                glowColor: colors.accent,
                                child: _AboutCard(
                                  title: 'What I like building',
                                  body:
                                      'Subscription products, operations tools, mapped experiences, payment flows, real-time behavior, and the kind of mobile apps where product reliability matters every day.',
                                ),
                              );

                              if (!isWide) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    first,
                                    const SizedBox(height: 20),
                                    second,
                                  ],
                                );
                              }

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: first),
                                  const SizedBox(width: 20),
                                  Expanded(child: second),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 72),
                        TimelineSection(entries: timeline),
                        const SizedBox(height: 72),
                        CapabilitiesSection(groups: capabilities),
                        const SizedBox(height: 72),
                        ScrollReveal(child: const ContactSection()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundTexture extends StatelessWidget {
  const _BackgroundTexture();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.06,
          child: CustomPaint(
            painter: _TexturePainter(
              lineColor: colors.border.withValues(alpha: 0.25),
            ),
          ),
        ),
      ),
    );
  }
}

class _TexturePainter extends CustomPainter {
  const _TexturePainter({required this.lineColor});

  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TexturePainter oldDelegate) =>
      oldDelegate.lineColor != lineColor;
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(body, style: textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
