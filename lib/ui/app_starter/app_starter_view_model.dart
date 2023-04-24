import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_state.dart';
import 'package:flutter_survey/usecases/is_logged_in_use_case.dart';

class AppStarterViewModel extends StateNotifier<AppStarterState> {
  final IsLoggedInUseCase _isLoggedInUseCase;

  AppStarterViewModel(this._isLoggedInUseCase)
      : super(const AppStarterState.init());

  void checkLoginStatus() async {
    state = const AppStarterState.loading();
    var isLoggedIn = await _isLoggedInUseCase.call();
    if (isLoggedIn) {
      state = const AppStarterState.showHomeScreen();
    } else {
      state = const AppStarterState.showLoginScreen();
    }
  }
}
