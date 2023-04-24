import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_state.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_view_model.dart';
import 'package:flutter_survey/ui/home/home_screen.dart';
import 'package:flutter_survey/ui/login/login_screen.dart';
import 'package:flutter_survey/usecases/get_log_in_status_use_case.dart';

final appStatretViewModelProvider =
    StateNotifierProvider.autoDispose<AppStarterViewModel, AppStarterState>(
        (ref) {
  return AppStarterViewModel(getIt.get<GetLogInStatusUseCase>());
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
    ref.read(appStatretViewModelProvider.notifier).checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AppStarterState>(appStatretViewModelProvider, (_, appState) {
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
