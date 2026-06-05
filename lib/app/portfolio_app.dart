import 'package:flutter/material.dart';

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
      theme: AppTheme.dark(),
      darkTheme: AppTheme.dark(),
      home: const PortfolioHomePage(),
    );
  }
}
