import 'package:flutter_config/flutter_config.dart';

class Env {
  static String get restApiEndpoint {
    return FlutterConfig.get('REST_API_ENDPOINT');
  }

  static String get restApiClientId {
    return FlutterConfig.get('REST_API_CLIENT_ID');
  }

  static String get restApiClientSecret {
    return FlutterConfig.get('REST_API_CLIENT_SECRET');
  }
}
