import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_state.dart';

class AppStarterViewModel extends StateNotifier<AppStarterState> {
  final SecureStorage _secureStorage;

  AppStarterViewModel(this._secureStorage)
      : super(const AppStarterState.init());

  void checkLoginStatus() async {
    state = const AppStarterState.loading();
    final String? accesstoken =
        await _secureStorage.readSecureData(accessTokenKey);
    final String? tokenType = await _secureStorage.readSecureData(tokenTypeKey);
    if (accesstoken != null && tokenType != null) {
      state = const AppStarterState.showHomeScreen();
    } else {
      state = const AppStarterState.showLoginScreen();
    }
  }
}
