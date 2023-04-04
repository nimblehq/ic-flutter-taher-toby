import 'dart:convert';
import 'dart:io';

class FileUtils {
  static Future<Map<String, dynamic>> loadFile(String path) async {
    final file = await File(path).readAsString();
    return jsonDecode(file);
  }
}
