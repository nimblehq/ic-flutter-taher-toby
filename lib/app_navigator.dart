import 'package:flutter/material.dart';
import 'package:flutter_survey/ui/home/home_screen.dart';
import 'package:flutter_survey/ui/second/second_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

const _routePathRootScreen = '/';
const _routePathSecondScreen = 'second';

class Routes {
  static final router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: _routePathRootScreen,
        builder: (BuildContext context, GoRouterState state) => HomeScreen(),
        routes: [
          GoRoute(
            path: _routePathSecondScreen,
            builder: (BuildContext context, GoRouterState state) =>
                const SecondScreen(),
          ),
        ],
      ),
    ],
  );
}

abstract class AppNavigator {
  void navigateToSecondScreen(BuildContext context);
}

@Injectable(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator {
  AppNavigatorImpl();

  @override
  void navigateToSecondScreen(BuildContext context) {
    context.go('/$_routePathSecondScreen');
  }
}
