import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import 'app/portfolio_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useFallbackTranslations: true,
      child: const PortfolioApp(),
    ),
  );
}
