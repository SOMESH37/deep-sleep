import 'dart:io' show Directory;
import 'package:path_provider/path_provider.dart';

class MyDirectory {
  MyDirectory._();

  static late final String _mainPath;

  static Future<void> init() async {
    final temp = await getApplicationDocumentsDirectory();
    _mainPath = temp.path;
  }

  static String get getCachePath => '$_mainPath/cache';
  static String get getDownloadPath => '$_mainPath/download';

  static Directory get getCacheDirectory => Directory(getCachePath);
  static Directory get getDownloadDirectory => Directory(getDownloadPath);
}
