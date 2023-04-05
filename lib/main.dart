import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/provider/di.dart';
import 'package:flutter_survey/theme/app_theme.dart';
import 'package:flutter_survey/app_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  configureDependencyInjection();
  _setTransparentStatusBar();
  runApp(const ProviderScope(
    child: SurveyApp(),
  ));
}

void _setTransparentStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

class SurveyApp extends StatelessWidget {
  const SurveyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: Routes.router.routeInformationProvider,
      routeInformationParser: Routes.router.routeInformationParser,
      routerDelegate: Routes.router.routerDelegate,
    );
  }
}
