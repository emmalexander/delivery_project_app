import 'package:path_provider/path_provider.dart';

class TemporalFilePathGenerator {
  static Future<String> createFilePath (String extensionType) async {
    final directory = await getApplicationDocumentsDirectory();

    final fileName = DateTime.now().millisecondsSinceEpoch;

    final filePath = "${directory.path}/$fileName.$extensionType";

    return filePath;
  }
}