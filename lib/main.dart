import 'package:firebase_core/firebase_core.dart';
import '/screens/rest/data.dart';
import 'exporter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  AssetsAudioPlayer.setupNotificationsOpenAction((_) => true);
  await Future.wait([
    Hive.initFlutter(),
    Firebase.initializeApp(),
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> /* with WidgetsBindingObserver */ {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addObserver(this);
    audioPlayer = AssetsAudioPlayer.withId('player')
        // ..open(
        //   Playlist(
        //     audios: List.generate(
        //       RestTileData.sleepItems.length,
        //       (i) {
        //         final item = RestTileData.sleepItems[i];
        //         return Audio.network(
        //           item.source,
        //           cached: true,
        //           metas: Metas(
        //             title: item.name,
        //             artist: 'Good sleep',
        //             image: MetasImage.asset(item.imgPath),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        //   autoStart: false,
        //   showNotification: true,
        //   loopMode: LoopMode.single,
        //   notificationSettings: const NotificationSettings(
        //     stopEnabled: false,
        //     nextEnabled: false,
        //     prevEnabled: false,
        //   ),
        // )
        ;
  }

  @override
  void dispose() {
    // WidgetsBinding.instance?.removeObserver(this);
    audioPlayer.dispose();
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (over) {
        over.disallowGlow();
        return false;
      },
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        navigatorKey: kAppNavigatorKey,
        title: 'Deep Sleep',
        theme: kAppTheme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            Screen.init(context);
            HiveHelper.init(context);
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
