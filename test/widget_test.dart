import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app/portfolio_app.dart';
import 'package:portfolio/features/projects/domain/portfolio_project.dart';
import 'package:portfolio/features/projects/widgets/project_showcase.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('hero renders core CTA buttons', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.byKey(const Key('hero_download_cv_button')), findsOneWidget);
    expect(find.byKey(const Key('hero_view_projects_button')), findsOneWidget);
    expect(find.byKey(const Key('hero_email_button')), findsOneWidget);
    expect(find.byKey(const Key('hero_whatsapp_button')), findsOneWidget);
  });

  testWidgets('project showcase list renders all project titles', (
    tester,
  ) async {
    await tester.pumpWidget(_TestHarness(child: _ProjectListTestBody()));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text('META POS Cashier', skipOffstage: false), findsWidgets);
    expect(find.text('MoStyle', skipOffstage: false), findsWidgets);
    expect(
      find.text('VOLTA EV Charging App', skipOffstage: false),
      findsWidgets,
    );
    expect(find.text('Refine Care', skipOffstage: false), findsWidgets);
  });

  testWidgets('project link buttons match available project links', (
    tester,
  ) async {
    await tester.pumpWidget(_TestHarness(child: _ProjectListTestBody()));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 800));

    expect(
      find.byKey(const Key('meta_pos_cashier_website'), skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('meta_pos_cashier_web_app'), skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('mostyle_play_store'), skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('mostyle_app_store'), skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('refine_care_play_store'), skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key('volta_ev_charging_app_play_store'),
        skipOffstage: false,
      ),
      findsNothing,
    );
  });
}

class _TestHarness extends StatelessWidget {
  const _TestHarness({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: child));
  }
}

class _ProjectListTestBody extends StatelessWidget {
  const _ProjectListTestBody();

  final projects = const [
    PortfolioProject(
      slug: 'meta_pos_cashier',
      title: 'META POS Cashier',
      category: 'Production Retail & Restaurant Operations',
      summary: 'summary',
      features: ['a', 'b', 'c', 'd'],
      techStack: ['Flutter'],
      roleSummary: 'role',
      status: ProjectStatus.live,
      links: [
        ProjectLink(
          id: 'website',
          label: 'Website',
          url: 'https://example.com',
          kind: ProjectLinkKind.website,
        ),
        ProjectLink(
          id: 'web_app',
          label: 'Web App',
          url: 'https://example.com/app',
          kind: ProjectLinkKind.web,
        ),
      ],
      imageAssets: [],
      accentColor: Color(0xFFFFB866),
    ),
    PortfolioProject(
      slug: 'mostyle',
      title: 'MoStyle',
      category: 'Fitness Subscription Product',
      summary: 'summary',
      features: ['a', 'b', 'c', 'd'],
      techStack: ['Flutter'],
      roleSummary: 'role',
      status: ProjectStatus.live,
      links: [
        ProjectLink(
          id: 'play_store',
          label: 'Play Store',
          url: 'https://example.com',
          kind: ProjectLinkKind.store,
        ),
        ProjectLink(
          id: 'app_store',
          label: 'App Store',
          url: 'https://example.com',
          kind: ProjectLinkKind.store,
        ),
      ],
      imageAssets: [],
      accentColor: Color(0xFF7FE7C4),
    ),
    PortfolioProject(
      slug: 'volta_ev_charging_app',
      title: 'VOLTA EV Charging App',
      category: 'EV Mobility & Charging Experience',
      summary: 'summary',
      features: ['a', 'b', 'c', 'd'],
      techStack: ['Flutter'],
      roleSummary: 'role',
      status: ProjectStatus.inProgress,
      links: [],
      imageAssets: [],
      accentColor: Color(0xFF6FB2FF),
    ),
    PortfolioProject(
      slug: 'refine_care',
      title: 'Refine Care',
      category: 'Healthcare Booking & Ordering',
      summary: 'summary',
      features: ['a', 'b', 'c', 'd'],
      techStack: ['Flutter'],
      roleSummary: 'role',
      status: ProjectStatus.live,
      links: [
        ProjectLink(
          id: 'play_store',
          label: 'Play Store',
          url: 'https://example.com',
          kind: ProjectLinkKind.store,
        ),
      ],
      imageAssets: [],
      accentColor: Color(0xFFFF8E8E),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            for (var index = 0; index < projects.length; index++) ...[
              if (index > 0) const SizedBox(height: 24),
              ProjectShowcase(
                project: projects[index],
                isReversed: index.isOdd,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
