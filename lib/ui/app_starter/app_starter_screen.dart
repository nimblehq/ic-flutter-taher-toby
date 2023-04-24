import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_state.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_view_model.dart';
import 'package:flutter_survey/ui/home/home_screen.dart';
import 'package:flutter_survey/ui/login/login_screen.dart';

final appStatretViewModelProvider =
    StateNotifierProvider.autoDispose<AppStarterViewModel, AppStarterState>(
        (ref) {
  return AppStarterViewModel(getIt.get<SecureStorage>());
});

class AppStarterScreen extends ConsumerStatefulWidget {
  const AppStarterScreen({Key? key}) : super(key: key);

  @override
  AppStarterScreenState createState() {
    return AppStarterScreenState();
  }
}

class AppStarterScreenState extends ConsumerState<AppStarterScreen> {
  @override
  void initState() {
    ref.read(appStatretViewModelProvider.notifier).checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(appStatretViewModelProvider).when(
          init: () => Container(),
          loading: () => Container(),
          showHomeScreen: () => const HomeScreen(),
          showLoginScreen: () => const LoginScreen(),
        );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
