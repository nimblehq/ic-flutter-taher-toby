import 'package:flutter/material.dart';
import 'package:flutter_survey/ui/login/login_screen.dart';
import 'package:flutter_survey/ui/form/form_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

const _routePathRootScreen = '/';
const _routePathFormScreen = 'form';

const _paramSurveyId = 'surveyId';

class Routes {
  static final router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: _routePathRootScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
        routes: [
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
  void navigateToFormScreen({
    required BuildContext context,
    required String surveyId,
  });
}

@Injectable(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator {
  AppNavigatorImpl();

  @override
  void navigateToFormScreen({
    required BuildContext context,
    required String surveyId,
  }) {
    context.go('/$_routePathFormScreen/$surveyId');
  }
}
