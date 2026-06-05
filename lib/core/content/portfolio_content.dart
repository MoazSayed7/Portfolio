import 'package:flutter/material.dart';

import '../../features/home/domain/timeline_entry.dart';
import '../../features/projects/domain/portfolio_project.dart';
import 'app_links.dart';

abstract final class PortfolioContent {
  static List<TimelineEntry> timeline() => [
    TimelineEntry(
      date: 'Sep 2020 – Jun 2023',
      title: 'High School — Misr International Computer & Ai',
      description:
          'Computer Programming diploma, graduated with Excellence. First hands-on programming: Java, SQL, PL/SQL & Arduino.',
      tags: ['Java', 'SQL', 'Arduino'],
    ),
    TimelineEntry(
      date: 'Oct 2023 – Present',
      title: 'B.Tech, Information Technology',
      description:
          'Currently studying a Bachelor of Technology in Information Technology at October Technological University.',
      tags: ['IT'],
    ),
    TimelineEntry(
      date: 'Early 2024',
      title: 'Discovered Flutter',
      description:
          'Began self-teaching Flutter & Dart and fell for building real mobile apps — first time programming ever.',
      tags: ['Flutter', 'Dart', 'Self-taught'],
    ),
    TimelineEntry(
      date: 'Apr 2024',
      title: 'First Freelance Project',
      description:
          'Landed first paid client via Kafiil on 23 April 2024 — turning brand-new skills into shipped work.',
      tags: ['Freelance', 'Kafiil'],
    ),
    TimelineEntry(
      date: 'Apr 2025 – Jun 2025',
      title: 'Flutter Developer Intern — Paymac',
      description:
          'Joined Paymac on-site as a Flutter Developer intern, working across production apps.',
      tags: ['Internship'],
    ),
    TimelineEntry(
      date: 'Jul 2025 – Present',
      title: 'Flutter Developer — Paymac',
      description:
          'Promoted to full-time. Building and shipping production Flutter products at Paymac.',
      tags: ['Full-time'],
    ),
  ];

  static List<String> credibilityPoints() => [
    'Flutter & Dart',
    'Firebase ecosystems',
    'GraphQL & REST APIs',
    'Payments & subscriptions',
    'Maps & QR flows',
    'Arabic / English apps',
    'App Store & Play Store shipping',
  ];

  static List<CapabilityGroup> capabilities() => [
    CapabilityGroup(
      title: 'Mobile Engineering',
      icon: Icons.phone_iphone_rounded,
      items: [
        'Flutter',
        'Dart',
        'Android & iOS delivery',
        'Responsive UI systems',
      ],
    ),
    CapabilityGroup(
      title: 'Architecture & State',
      icon: Icons.account_tree_outlined,
      items: [
        'Bloc / Cubit',
        'Feature-based architecture',
        'Dependency injection',
        'Clean implementation patterns',
      ],
    ),
    CapabilityGroup(
      title: 'Backend & Integrations',
      icon: Icons.cloud_outlined,
      items: [
        'Firebase',
        'GraphQL & REST APIs',
        'Dio / Retrofit',
        'Notifications, auth, analytics',
      ],
    ),
    CapabilityGroup(
      title: 'Product Workflows',
      icon: Icons.insights_outlined,
      items: [
        'Subscriptions & payments',
        'POS and business operations',
        'Healthcare booking',
        'Maps, QR, localization',
      ],
    ),
  ];

  static List<PortfolioProject> projects() => [
    PortfolioProject(
      slug: 'meta_pos_cashier',
      title: 'META POS Cashier',
      category: 'Production Retail & Restaurant Operations',
      summary:
          'A large-scale cross-platform POS system built for real store and restaurant workflows, covering cashiering, inventory, warehouse, kitchen operations, reporting, and hardware integrations.',
      features: [
        'Cashier, sales, refunds, purchases, and return flows',
        'Inventory, warehouse, manufacturing, and shift closing workflows',
        'Barcode scanning, label generation, and invoice printing',
        'Offline persistence, sync recovery, and multilingual support',
      ],
      techStack: const [
        'Flutter',
        'Bloc/Cubit',
        'GraphQL',
        'Hive',
        'Firebase',
        'Sentry',
      ],
      roleSummary:
          'Built complex operational flows, multi-platform UI, offline-aware behavior, backend integrations, localization, and hardware-driven cashier experiences.',
      status: ProjectStatus.live,
      links: const [
        ProjectLink(
          id: 'website',
          label: 'Website',
          url: AppLinks.metaPosWebsite,
          kind: ProjectLinkKind.website,
        ),
        ProjectLink(
          id: 'web_app',
          label: 'Web App',
          url: AppLinks.metaPosWeb,
          kind: ProjectLinkKind.web,
        ),
        ProjectLink(
          id: 'play_store',
          label: 'Play Store',
          url: AppLinks.metaPosPlayStore,
          kind: ProjectLinkKind.store,
        ),
        ProjectLink(
          id: 'app_store',
          label: 'App Store',
          url: AppLinks.metaPosAppStore,
          kind: ProjectLinkKind.store,
        ),
      ],
      imageAssets: const [],
      accentColor: const Color(0xFFE8B87A),
    ),
    PortfolioProject(
      slug: 'mostyle',
      title: 'MoStyle',
      category: 'Fitness Subscription Product',
      summary:
          'A personalized fitness app centered on onboarding, workout plan delivery, guided sessions, subscriptions, referrals, and progress tracking across a polished consumer experience.',
      features: [
        'Email, Google, and Apple authentication',
        'Workout plans tailored to user preferences',
        'Trial, referral, and subscription payment flows',
        'Progress analytics, notifications, and preference handling',
      ],
      techStack: const [
        'Flutter',
        'Firebase',
        'Stripe',
        'Bloc/Cubit',
        'GetIt',
        'Dio',
      ],
      roleSummary:
          'Worked on app architecture, authentication, subscriptions, analytics, progress tracking, notification behavior, and responsive UI delivery.',
      status: ProjectStatus.live,
      links: const [
        ProjectLink(
          id: 'play_store',
          label: 'Play Store',
          url: AppLinks.moStylePlayStore,
          kind: ProjectLinkKind.store,
        ),
        ProjectLink(
          id: 'app_store',
          label: 'App Store',
          url: AppLinks.moStyleAppStore,
          kind: ProjectLinkKind.store,
        ),
      ],
      imageAssets: const [
        'assets/images/projects/mostyle/screen_1.webp',
        'assets/images/projects/mostyle/screen_2.webp',
      ],
      accentColor: const Color(0xFF7ED4C0),
    ),
    PortfolioProject(
      slug: 'volta_ev_charging_app',
      title: 'VOLTA EV Charging App',
      category: 'EV Mobility & Charging Experience',
      summary:
          'A production-style EV charging product that helps drivers discover stations, reserve chargers, activate sessions through QR scanning, track charging, and manage wallet and commerce flows.',
      features: [
        'Station discovery with charger availability and connector detail',
        'Reservation flows and QR-based charging activation',
        'Wallet, transactions, deep linking, and multilingual support',
        'EV accessories shop with cart, checkout, and order flows',
      ],
      techStack: const [
        'Flutter',
        'Cubit',
        'Dio',
        'Retrofit',
        'Freezed',
        'Google Maps',
      ],
      roleSummary:
          'Built layered app flows around mapping, QR-based charging, secure persistence, localization, and commerce-oriented user journeys.',
      status: ProjectStatus.inProgress,
      links: const [],
      imageAssets: const [],
      accentColor: const Color(0xFF7BAEE8),
    ),
    PortfolioProject(
      slug: 'refine_care',
      title: 'Refine Care',
      category: 'Healthcare Booking & Ordering',
      summary:
          'A healthcare and laboratory booking app that supports discovery, cart and checkout, online payment, order tracking, wallet flows, and bilingual customer experiences.',
      features: [
        'OTP authentication and profile management',
        'Nearby laboratories, services, search, and filtering',
        'Cart, payment continuation, order tracking, refunds, and reorder',
        'Invoice sharing, wallet management, and notifications',
      ],
      techStack: const [
        'Flutter',
        'Provider',
        'Dio',
        'Firebase',
        'WebView',
        'ScreenUtil',
      ],
      roleSummary:
          'Built and maintained core screens and flows, integrated APIs, implemented payments, notifications, localization, and reliability improvements with Crashlytics.',
      status: ProjectStatus.live,
      links: const [
        ProjectLink(
          id: 'play_store',
          label: 'Play Store',
          url: AppLinks.refineCarePlayStore,
          kind: ProjectLinkKind.store,
        ),
      ],
      imageAssets: const [],
      accentColor: const Color(0xFFE89BB0),
    ),
  ];
}
