import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String accessTokenKey = "accessTokenKey";
const String refreshTokenKey = "refreshTokenKey";
const String tokenTypeKey = "tokenTypeKey";

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

abstract class SecureStorage {
  Future<void> writeSecureData(String key, String value);
  Future<String?> readSecureData(String key);
}

class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorageImpl(this._secureStorage);

  @override
  Future<void> writeSecureData(String key, String value) async {
    await _secureStorage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
    );
  }

  @override
  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(
      key: key,
      aOptions: _getAndroidOptions(),
    );
    return readData;
  }
}
