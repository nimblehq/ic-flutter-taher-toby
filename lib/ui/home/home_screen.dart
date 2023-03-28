import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/api/repository/credential_repository.dart';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/di/provider/di.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _appNavigator = getIt.get<AppNavigator>();
  final _credentialRepository = getIt.get<CredentialRepository>();

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
              onPressed: () => _appNavigator.navigateToSecondScreen(context),
              child: Text(
                "Navigate to Second Screen",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: () => _credentialRepository.getUsers(),
              child: Text(
                "Get Users",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
    return Stack(
      children: [
        const HomeHeader(),
      ],
    );
  }
}
