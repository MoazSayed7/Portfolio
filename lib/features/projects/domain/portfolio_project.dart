import 'package:flutter/material.dart';

enum ProjectStatus { live, inProgress }

enum ProjectLinkKind { live, github, store, web, website }

class ProjectLink {
  const ProjectLink({
    required this.id,
    required this.label,
    required this.url,
    required this.kind,
  });

  final String id;
  final String label;
  final String url;
  final ProjectLinkKind kind;
}

class PortfolioProject {
  const PortfolioProject({
    required this.slug,
    required this.title,
    required this.category,
    required this.summary,
    required this.features,
    required this.techStack,
    required this.roleSummary,
    required this.status,
    required this.links,
    required this.imageAssets,
    required this.accentColor,
  });

  final String slug;
  final String title;
  final String category;
  final String summary;
  final List<String> features;
  final List<String> techStack;
  final String roleSummary;
  final ProjectStatus status;
  final List<ProjectLink> links;
  final List<String> imageAssets;
  final Color accentColor;
}

class CapabilityGroup {
  const CapabilityGroup({
    required this.title,
    required this.items,
    required this.icon,
  });

  final String title;
  final List<String> items;
  final IconData icon;
}
