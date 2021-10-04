import '/exporter.dart';

class DrawerData {
  String name;
  IconData icon;
  Widget? screen;
  DrawerData._({
    required this.name,
    required this.icon,
    this.screen,
  });
  static final items = <DrawerData>[
    // DrawerData._(
    //   name: 'Notifications',
    //   icon: Icons.notifications_rounded,
    //   screen: Notifications(),
    // ),
    DrawerData._(
      name: 'Usage',
      icon: Icons.bar_chart_rounded,
      screen: Usage(),
    ),
    DrawerData._(
      name: 'Settings',
      icon: Icons.settings_rounded,
      screen: Setting(),
    ),
    DrawerData._(
      name: 'Rate us on play store ',
      icon: Icons.star_rate_rounded,
    ),
  ];
}

class DashboardData {
  String name;
  String appBarTitle;
  String iconPath;
  Widget screen;
  GlobalKey<NavigatorState> navigatorKey;
  DashboardData._({
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
      appBarTitle: 'For you',
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
