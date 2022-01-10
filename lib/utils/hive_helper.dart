import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/rest/data.dart';

enum DownloadStatus { notDownloaded, downloading, downloaded }

class HiveHelper {
  HiveHelper._();

  static late Box<Map> napUsageBox;
  static late Box<Map> sleepUsageBox;
  static late Box<int> downloadStatBox;
  static late Box<List<String>> userMixesBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    downloadStatBox = await Hive.openBox('download_stat');
    napUsageBox = await Hive.openBox('usage_nap');
    sleepUsageBox = await Hive.openBox('usage_sleep');
    userMixesBox = await Hive.openBox('user_mixes_box');
    syncFirestore();
    updateDownloadBox();
  }

  static Future<void> signOut() async {
    await Future.wait([
      napUsageBox.clear(),
      sleepUsageBox.clear(),
      userMixesBox.clear(),
      syncFirestore(),
    ]);
  }

  static Future<void> syncFirestore() async {
    // TODO
  }

  static DownloadStatus downloadStat(String? name) {
    if (name == null) return DownloadStatus.notDownloaded;
    if (HiveHelper.downloadStatBox.containsKey(name)) {
      return ((HiveHelper.downloadStatBox.get(name) ?? 0) > 100)
          ? DownloadStatus.downloaded
          : DownloadStatus.downloading;
    } else {
      return DownloadStatus.notDownloaded;
    }
  }

  static void delete(String name) {
    final path = '${MyDirectory.getDownloadPath}/$name';
    downloadStatBox.delete(name);
    File(path).deleteSync();
  }

  /// Must not be called while downloading
  static void updateDownloadBox() {
    downloadStatBox.keys.forEach(_removeKeyIfNotExistOrIncomplete);
    MyDirectory.getDownloadDirectory.list().forEach(_deleteFileIfNotExist);
  }

  static Future<void> _deleteFileIfNotExist(FileSystemEntity fes) async {
    if (!downloadStatBox.containsKey(fes.path.split('/').last)) {
      File(fes.path).delete();
    }
  }

  static Future<void> _removeKeyIfNotExistOrIncomplete(key) async {
    final path = '${MyDirectory.getDownloadPath}/$key';
    if (downloadStatBox.get(key)! <= 100) {
      downloadStatBox.delete(key);
      File(path).delete();
    } else if (!File(path).existsSync()) {
      downloadStatBox.delete(key);
    }
  }

  static void saveUsageData(String? mixName) {
    final isNap = RestTileData.napItems.any((e) => mixName == e.name);
    final isSleep = RestTileData.sleepItems.any((e) => mixName == e.name);
    if (isSleep || isNap) {
      final currentSec = Jiffy().unix();
      final currentDateInt = Jiffy().toIntDate;
      final box = isNap ? napUsageBox : sleepUsageBox;
      final mapData = box.get(currentDateInt);
      final data = mapData == null
          ? UsageTileData(
              names: {},
              seconds: 0,
              date: currentDateInt,
              lastSavedTimeSec: currentSec - 1,
            )
          : UsageTileData.fromMap(mapData);
      if (data.lastSavedTimeSec < currentSec) {
        data
          ..lastSavedTimeSec = currentSec
          ..names.add(mixName!)
          ..seconds += 1;
        box.put(currentDateInt, data.toMap());
      }
    }
  }
}
