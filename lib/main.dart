import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/api/api_service.dart';
import 'package:flutter_survey/api/repository/credential_repository.dart';
import 'package:flutter_survey/di/provider/di.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  configureDependencyInjection();
  runApp(MyApp());
}

const routePathRootScreen = '/';
const routePathSecondScreen = 'second';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: routePathRootScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
        routes: [
          GoRoute(
            path: routePathSecondScreen,
            builder: (BuildContext context, GoRouterState state) =>
                const SecondScreen(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}

final credentialRepository = CredentialRepositoryImpl(getIt.get<ApiService>());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text(
                      snapshot.data?.appName ?? "",
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  : const SizedBox.shrink();
            }),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.spacing24),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Image.asset(
                Assets.images.nimbleLogo.path,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing24),
            Text(
              AppLocalizations.of(context)!.hello,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: AppDimensions.spacing24),
            Text(
              FlutterConfig.get('SECRET'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppDimensions.spacing24),
            Text(
              FlutterConfig.get('REST_API_ENDPOINT'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: () => context.go('/$routePathSecondScreen'),
              child: Text(
                "Navigate to Second Screen",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: () => credentialRepository.getUsers(),
              child: Text(
                "Get Users",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
    );
  }
}
