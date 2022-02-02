import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/experience/data.dart';

enum DownloadStatus { notDownloaded, downloading, downloaded }

class HiveHelper {
  HiveHelper._();
  static late Box<int> downloadStatBox;
  static late Box<List<String>> userMixesBox;
  static late Box<Map> restUsageBox;
  static late Box<Map> experienceUsageBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    downloadStatBox = await Hive.openBox('download_stat');
    userMixesBox = await Hive.openBox('user_mixes_box');
    restUsageBox = await Hive.openBox('usage_rest');
    experienceUsageBox = await Hive.openBox('usage_experience');
    updateDownloadBox();
  }

  static Future<void> signOut() async {
    closeAudioPlayer();
    await putFireStore();
    await Future.wait([
      userMixesBox.clear(),
      restUsageBox.clear(),
      experienceUsageBox.clear(),
    ]);
    await FirebaseAuth.instance.signOut();
  }

  static CollectionReference<Map<String, dynamic>>? get userCollection {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.isAnonymous) return null;
    return FirebaseFirestore.instance.collection(user.uid);
  }

  /// Upload all user data saved in local storage [Hive] to
  /// online storage [FireStore] for signed users only
  static Future<void> putFireStore({bool onlyMix = false}) async {
    final temp = userCollection;
    if (temp == null) return;
    try {
      await Future.wait(
        [
          userMixesBox,
          if (!onlyMix) restUsageBox,
          if (!onlyMix) experienceUsageBox,
        ].map(
          (e) => temp.doc(e.name).set(e.toTypeMap),
        ),
      );
    } catch (_) {
      debugPrint('Upload to firestore failed');
    }
  }

  /// Get all user data from online storage [FireStore]
  /// and saves it in local storage [Hive]
  static Future<void> pullFireStore() async {
    final temp = userCollection;
    if (temp == null) return;
    try {
      final snap = await temp.get();
      for (final item in snap.docs) {
        // Hive.box(item.id) throws error
        if (item.id == userMixesBox.name) {
          userMixesBox.putAll(
            item.data().map((k, v) => MapEntry(k, (v as List).cast<String>())),
          );
        } else if (item.id == restUsageBox.name) {
          restUsageBox.putAll(
            item.data().map((k, v) => MapEntry(int.parse(k), v as Map)),
          );
        } else if (item.id == experienceUsageBox.name) {
          experienceUsageBox.putAll(
            item.data().map(
                  (k, v) => MapEntry(int.parse(k), v as Map),
                ),
          );
        }
      }
    } catch (_) {
      debugPrint('Failed to get data from firestore');
    }
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

  static void saveUsageData(String? name) {
    if (name?.isEmpty ?? true) return;
    final isExp = ExpTileData.items.any((e) => name == e.name);
    final currentSec = Jiffy().unix();
    final currentDateInt = Jiffy().toIntDate;
    final box = isExp ? experienceUsageBox : restUsageBox;
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
        ..names.add(name!)
        ..seconds += 1;
      box.put(currentDateInt, data.toMap());
    }
  }
}
