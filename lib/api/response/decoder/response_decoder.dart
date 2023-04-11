import 'package:japx/japx.dart';

Map<String, dynamic> decodeJson(Map<String, dynamic> json) {
  return Japx.decode(json);
}

Map<String, dynamic> decodeJsonFromData(Map<String, dynamic> json) {
  return Japx.decode(json)['data'];
}
