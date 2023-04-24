import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_state.dart';
import 'package:flutter_survey/usecases/get_log_in_status_use_case.dart';

class AppStarterViewModel extends StateNotifier<AppStarterState> {
  final GetLogInStatusUseCase _getLogInStatusUseCase;

  AppStarterViewModel(this._getLogInStatusUseCase)
      : super(const AppStarterState.init());

  void checkLoginStatus() async {
    state = const AppStarterState.loading();
    var isLoggedIn = await _getLogInStatusUseCase.call();
    if (isLoggedIn) {
      state = const AppStarterState.showHomeScreen();
    } else {
      state = const AppStarterState.showLoginScreen();
    }
  }
}
