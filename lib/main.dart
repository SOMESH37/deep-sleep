import 'package:deep_sleep/exporter.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colours.scaffold,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  AssetsAudioPlayer.setupNotificationsOpenAction((_) => true);
  await Future.wait([
    HiveHelper.init(),
    MyDirectory.init(),
    Firebase.initializeApp(),
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), HiveHelper.putFireStore);

    final cache = AssetsAudioPlayerCache(
      audioKeyTransformer: (audio) async =>
          removeHttpSpecialCharsFromStrings(audio.path),
      cachePathProvider: (_, key) async => '${MyDirectory.getCachePath}/$key',
    );

    AssetsAudioPlayer getAudioPlayer(String id) {
      return AssetsAudioPlayer.withId(id)
        ..cachePathProvider = cache
        ..realtimePlayingInfos.listen((v) {
          if (v.isPlaying) {
            HiveHelper.saveUsageData(v.current?.audio.audio.metas.title);
          }
        });
    }

    audioPlayer = getAudioPlayer('main');
    expPlayer = getAudioPlayer('exp');
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    expPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (over) {
        over.disallowIndicator();
        return false;
      },
      child: MaterialApp(
        title: 'Deep Sleep',
        theme: kAppTheme,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            Screen.init(context);
            if (snap.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colours.elevationButton,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              );
            } else if (snap.hasData) {
              return Dashboard();
            } else {
              return const OnBoard();
            }
          },
        ),
      ),
    );
  }
}
