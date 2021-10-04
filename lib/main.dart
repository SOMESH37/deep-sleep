import 'package:firebase_core/firebase_core.dart';
import 'exporter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: NotificationListener<OverscrollIndicatorNotification>(
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
      ),
    );
  }
}
