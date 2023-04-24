import 'package:flutter/material.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_screen.dart';
import 'package:flutter_survey/ui/home/home_screen.dart';
import 'package:flutter_survey/ui/form/form_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

const _routePathRootScreen = '/';
const _routePathHomeScreen = 'home';
const _routePathFormScreen = 'form';
const _paramSurveyId = 'surveyId';

class Routes {
  static final router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: _routePathRootScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const AppStarterScreen();
        },
        routes: [
          GoRoute(
            path: _routePathHomeScreen,
            builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
          ),
          GoRoute(
            path: '$_routePathFormScreen/:$_paramSurveyId',
            builder: (BuildContext context, GoRouterState state) {
              final surveyId = state.params[_paramSurveyId] as String;
              return FormScreen(surveyId: surveyId);
            },
          ),
        ],
      ),
    ],
  );
}

abstract class AppNavigator {
  void navigateBack(BuildContext context);
  void navigateToHomeScreen({required BuildContext context});
  void navigateToFormScreen({
    required BuildContext context,
    required String surveyId,
  });
}

@Injectable(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator {
  AppNavigatorImpl();

  @override
  void navigateBack(BuildContext context) => Navigator.of(context).pop();

  @override
  void navigateToHomeScreen({required BuildContext context}) {
    context.go('$_routePathRootScreen$_routePathHomeScreen');
  }

  @override
  void navigateToFormScreen({
    required BuildContext context,
    required String surveyId,
  }) {
    context.go('/$_routePathFormScreen/$surveyId');
  }
}
