import '/exporter.dart';

final kAppTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colours.scaffold,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      primary: Colours.elevationButton,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: const StadiumBorder(),
      primary: Colors.white70,
    ),
  ),
);
