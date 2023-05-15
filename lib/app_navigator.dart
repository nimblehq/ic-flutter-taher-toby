import 'package:flutter/material.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_screen.dart';
import 'package:flutter_survey/ui/home/home_screen.dart';
import 'package:flutter_survey/ui/form/form_screen.dart';
import 'package:flutter_survey/ui/login/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

const _routePathRootScreen = '/';
const _routePathLoginScreen = 'login';
const _routePathHomeScreen = 'home';
const _routePathFormScreen = 'form';
const _routePathSurveySuccess = 'surveySuccess';
const _paramSurveySuccessMessage = 'message';
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
            path: _routePathLoginScreen,
            builder: (BuildContext context, GoRouterState state) =>
                const LoginScreen(),
          ),
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
          GoRoute(
            path: '$_routePathSurveySuccess/:$_paramSurveySuccessMessage',
            builder: (BuildContext context, GoRouterState state) {
              final message =
                  state.params[_paramSurveySuccessMessage] as String;
              // TODO: Add new screen at  task #42
              return Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
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
  void navigateToLoginScreen({required BuildContext context});
  void navigateToFormScreen({
    required BuildContext context,
    required String surveyId,
  });
  void navigateToSurveySuccessScreen({
    required BuildContext context,
    required String message,
  });
}

@Injectable(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator {
  AppNavigatorImpl();

  @override
  void navigateBack(BuildContext context) => Navigator.of(context).pop();

  @override
  void navigateToHomeScreen({required BuildContext context}) {
    context.replace('/$_routePathHomeScreen');
  }

  @override
  void navigateToLoginScreen({required BuildContext context}) {
    context.replace('/$_routePathLoginScreen');
  }

  @override
  void navigateToFormScreen({
    required BuildContext context,
    required String surveyId,
  }) {
    context.push('/$_routePathFormScreen/$surveyId');
  }

  @override
  void navigateToSurveySuccessScreen({
    required BuildContext context,
    required String message,
  }) {
    context.replace('/$_routePathSurveySuccess/$message');
  }
}
