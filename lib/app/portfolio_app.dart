import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/content/portfolio_content.dart';
import '../features/home/presentation/portfolio_home_page.dart';
import 'theme/app_theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moaz Sayed | Flutter Developer',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.dark(context.locale),
      darkTheme: AppTheme.dark(context.locale),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: PortfolioHomePage(
        key: ValueKey(context.locale.toString()),
        projects: PortfolioContent.projects(context),
        capabilities: PortfolioContent.capabilities(context),
        credibilityPoints: PortfolioContent.credibilityPoints(context),
        timeline: PortfolioContent.timeline(context),
      ),
    );
  }
}
