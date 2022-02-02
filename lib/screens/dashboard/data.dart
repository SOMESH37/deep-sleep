import 'package:deep_sleep/exporter.dart';

class DrawerData {
  String name;
  IconData icon;
  Function(BuildContext c) onTap;
  DrawerData._({
    required this.name,
    required this.icon,
    required this.onTap,
  });
  static final items = <DrawerData>[
    DrawerData._(
      name: 'Usage',
      icon: Icons.bar_chart_rounded,
      onTap: (c) => Usage().push(c),
    ),
    DrawerData._(
      name: 'Settings',
      icon: Icons.settings_rounded,
      onTap: (c) => Setting().push(c),
    ),
    DrawerData._(
      name: 'Rate us on play store ',
      icon: Icons.star_rate_rounded,
      onTap: (c) => launch(
        'https://play.google.com/store/apps/details?id=com.myrl.deep_sleep',
      ),
    ),
  ];
}

class DashboardData {
  final String name;
  final String appBarTitle;
  final String iconPath;
  final Widget screen;
  final GlobalKey<NavigatorState> navigatorKey;

  const DashboardData._({
    required this.name,
    required this.screen,
    required this.appBarTitle,
    required this.iconPath,
    required this.navigatorKey,
  });
  static final items = <DashboardData>[
    DashboardData._(
      name: 'For you',
      screen: ForYou(),
      appBarTitle: 'Welcome back 👋',
      iconPath: Assets.navBarOne.path,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    DashboardData._(
      name: 'Rest',
      screen: Rest(),
      appBarTitle: 'Rest',
      iconPath: Assets.navBarTwo.path,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    DashboardData._(
      name: 'Experience',
      screen: Experience(),
      appBarTitle: 'Experience',
      iconPath: Assets.navBarThree.path,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    DashboardData._(
      name: 'Learn',
      screen: Learn(),
      appBarTitle: 'Learning center',
      iconPath: Assets.navBarFour.path,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  ];
}
