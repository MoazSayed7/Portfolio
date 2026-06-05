import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../features/home/domain/timeline_entry.dart';
import '../../features/projects/domain/portfolio_project.dart';
import 'app_links.dart';

abstract final class PortfolioContent {
  static List<TimelineEntry> timeline(BuildContext context) => [
    TimelineEntry(
      date: tr('timeline.entries.0.date'),
      title: tr('timeline.entries.0.title'),
      description: tr('timeline.entries.0.description'),
      tags: [
        tr('timeline.entries.0.tags.0'),
        tr('timeline.entries.0.tags.1'),
        tr('timeline.entries.0.tags.2'),
      ],
    ),
    TimelineEntry(
      date: tr('timeline.entries.1.date'),
      title: tr('timeline.entries.1.title'),
      description: tr('timeline.entries.1.description'),
      tags: [tr('timeline.entries.1.tags.0')],
    ),
    TimelineEntry(
      date: tr('timeline.entries.2.date'),
      title: tr('timeline.entries.2.title'),
      description: tr('timeline.entries.2.description'),
      tags: [
        tr('timeline.entries.2.tags.0'),
        tr('timeline.entries.2.tags.1'),
        tr('timeline.entries.2.tags.2'),
      ],
    ),
    TimelineEntry(
      date: tr('timeline.entries.3.date'),
      title: tr('timeline.entries.3.title'),
      description: tr('timeline.entries.3.description'),
      tags: [tr('timeline.entries.3.tags.0'), tr('timeline.entries.3.tags.1')],
    ),
    TimelineEntry(
      date: tr('timeline.entries.4.date'),
      title: tr('timeline.entries.4.title'),
      description: tr('timeline.entries.4.description'),
      tags: [tr('timeline.entries.4.tags.0')],
    ),
    TimelineEntry(
      date: tr('timeline.entries.5.date'),
      title: tr('timeline.entries.5.title'),
      description: tr('timeline.entries.5.description'),
      tags: [tr('timeline.entries.5.tags.0')],
    ),
  ];

  static List<String> credibilityPoints(BuildContext context) => [
    tr('credibility.flutter'),
    tr('credibility.firebase'),
    tr('credibility.apis'),
    tr('credibility.payments'),
    tr('credibility.maps'),
    tr('credibility.localization'),
    tr('credibility.shipping'),
  ];

  static List<CapabilityGroup> capabilities(BuildContext context) => [
    CapabilityGroup(
      title: tr('capabilities.mobile.title'),
      icon: Icons.phone_iphone_rounded,
      items: [
        tr('capabilities.mobile.items.0'),
        tr('capabilities.mobile.items.1'),
        tr('capabilities.mobile.items.2'),
        tr('capabilities.mobile.items.3'),
      ],
    ),
    CapabilityGroup(
      title: tr('capabilities.architecture.title'),
      icon: Icons.account_tree_outlined,
      items: [
        tr('capabilities.architecture.items.0'),
        tr('capabilities.architecture.items.1'),
        tr('capabilities.architecture.items.2'),
        tr('capabilities.architecture.items.3'),
      ],
    ),
    CapabilityGroup(
      title: tr('capabilities.backend.title'),
      icon: Icons.cloud_outlined,
      items: [
        tr('capabilities.backend.items.0'),
        tr('capabilities.backend.items.1'),
        tr('capabilities.backend.items.2'),
        tr('capabilities.backend.items.3'),
      ],
    ),
    CapabilityGroup(
      title: tr('capabilities.product.title'),
      icon: Icons.insights_outlined,
      items: [
        tr('capabilities.product.items.0'),
        tr('capabilities.product.items.1'),
        tr('capabilities.product.items.2'),
        tr('capabilities.product.items.3'),
      ],
    ),
  ];

  static List<PortfolioProject> projects(BuildContext context) => [
    PortfolioProject(
      slug: 'meta_pos_cashier',
      title: 'META POS Cashier',
      category: tr('projects.meta_pos.category'),
      summary: tr('projects.meta_pos.summary'),
      features: [
        tr('projects.meta_pos.features.0'),
        tr('projects.meta_pos.features.1'),
        tr('projects.meta_pos.features.2'),
        tr('projects.meta_pos.features.3'),
      ],
      techStack: const [
        'Flutter',
        'Bloc/Cubit',
        'GraphQL',
        'Hive',
        'Firebase',
        'Sentry',
      ],
      roleSummary: tr('projects.meta_pos.role'),
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
      category: tr('projects.mostyle.category'),
      summary: tr('projects.mostyle.summary'),
      features: [
        tr('projects.mostyle.features.0'),
        tr('projects.mostyle.features.1'),
        tr('projects.mostyle.features.2'),
        tr('projects.mostyle.features.3'),
      ],
      techStack: const [
        'Flutter',
        'Firebase',
        'Stripe',
        'Bloc/Cubit',
        'GetIt',
        'Dio',
      ],
      roleSummary: tr('projects.mostyle.role'),
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
      imageAssets: const [],
      accentColor: const Color(0xFF7ED4C0),
    ),
    PortfolioProject(
      slug: 'volta_ev_charging_app',
      title: 'VOLTA EV Charging App',
      category: tr('projects.volta.category'),
      summary: tr('projects.volta.summary'),
      features: [
        tr('projects.volta.features.0'),
        tr('projects.volta.features.1'),
        tr('projects.volta.features.2'),
        tr('projects.volta.features.3'),
      ],
      techStack: const [
        'Flutter',
        'Cubit',
        'Dio',
        'Retrofit',
        'Freezed',
        'Google Maps',
      ],
      roleSummary: tr('projects.volta.role'),
      status: ProjectStatus.inProgress,
      links: const [],
      imageAssets: const [],
      accentColor: const Color(0xFF7BAEE8),
    ),
    PortfolioProject(
      slug: 'refine_care',
      title: 'Refine Care',
      category: tr('projects.refine.category'),
      summary: tr('projects.refine.summary'),
      features: [
        tr('projects.refine.features.0'),
        tr('projects.refine.features.1'),
        tr('projects.refine.features.2'),
        tr('projects.refine.features.3'),
      ],
      techStack: const [
        'Flutter',
        'Provider',
        'Dio',
        'Firebase',
        'WebView',
        'ScreenUtil',
      ],
      roleSummary: tr('projects.refine.role'),
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
