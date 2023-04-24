import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_state.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_view_model.dart';
import 'package:flutter_survey/usecases/is_logged_in_use_case.dart';

final appStarterViewModelProvider =
    StateNotifierProvider.autoDispose<AppStarterViewModel, AppStarterState>(
        (ref) {
  return AppStarterViewModel(getIt.get<IsLoggedInUseCase>());
});

class AppStarterScreen extends ConsumerStatefulWidget {
  const AppStarterScreen({Key? key}) : super(key: key);

  @override
  AppStarterScreenState createState() {
    return AppStarterScreenState();
  }
}

class AppStarterScreenState extends ConsumerState<AppStarterScreen> {
  final _appNavigator = getIt.get<AppNavigator>();

  @override
  void initState() {
    ref.read(appStarterViewModelProvider.notifier).checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AppStarterState>(appStarterViewModelProvider, (_, appState) {
      appState.maybeWhen(
        showHomeScreen: () => _navigateToHomeScreen(),
        showLoginScreen: () => _navigateToLoginScreen(),
        orElse: () {},
      );
    });
    return Scaffold(body: Container());
  }

  void _navigateToHomeScreen() {
    _appNavigator.navigateToHomeScreen(context: context);
  }

  void _navigateToLoginScreen() {
    _appNavigator.navigateToLoginScreen(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
