import 'package:flutter/material.dart';
import 'package:flutter_survey/database/shared_preferences.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/ui/home/home_screen.dart';
import 'package:flutter_survey/ui/login/login_screen.dart';

class AppStarter extends StatelessWidget {
  AppStarter({super.key});

  final _sharedPreferences = getIt<SharedPreferencesStorage>();

  @override
  Widget build(BuildContext context) {
    return _sharedPreferences.isLoggedIn
        ? const HomeScreen()
        : const LoginScreen();
  }
}
