import 'package:flutter/material.dart';
import 'package:flutter_survey/ui/login/login_screen.dart';
import 'package:flutter_survey/ui/form/form_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

const _routePathRootScreen = '/';
const _routePathFormScreen = 'form';

class Routes {
  static final router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: _routePathRootScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
        routes: [
          GoRoute(
            path: _routePathFormScreen,
            builder: (BuildContext context, GoRouterState state) =>
                FormScreen(),
          ),
        ],
      ),
    ],
  );
}

abstract class AppNavigator {
  void navigateToFormScreen(BuildContext context);
}

@Injectable(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator {
  AppNavigatorImpl();

  @override
  void navigateToFormScreen(BuildContext context) {
    context.go('/$_routePathFormScreen');
  }
}
