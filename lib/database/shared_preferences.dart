import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesStorage {
  bool get isLoggedIn;

  void saveLoginStatus(bool isLoggedIn);
  void clear();
}

const String _loginStatusKey = "loginStatusKey";

class SharedPreferencesStorageImpl extends SharedPreferencesStorage {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesStorageImpl(this._sharedPreferences);

  @override
  bool get isLoggedIn => _sharedPreferences.getBool(_loginStatusKey) ?? false;

  @override
  void saveLoginStatus(bool isLoggedIn) async {
    await _sharedPreferences.setBool(_loginStatusKey, isLoggedIn);
  }

  @override
  void clear() async {
    await _sharedPreferences.clear();
  }
}
