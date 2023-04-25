import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_starter_state.freezed.dart';

@freezed
class AppStarterState with _$AppStarterState {
  const factory AppStarterState.init() = _Init;

  const factory AppStarterState.loading() = _Loading;

  const factory AppStarterState.showHomeScreen() = _ShowHomeScreen;

  const factory AppStarterState.showLoginScreen() = _ShowLoginScreen;
}
