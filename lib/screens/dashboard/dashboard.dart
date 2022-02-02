import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/dashboard/data.dart';
import 'package:deep_sleep/screens/dashboard/drawer.dart';

class Dashboard extends StatefulWidget {
  static const pad = 16.0;
  static const openPlayerHeight = 56.0;
  static final swipeDuration = kAnimationDuration * 0.4;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _currentIndex = 0;
  final _screens = List.generate(
    DashboardData.items.length,
    (i) => Navigator(
      key: DashboardData.items[i].navigatorKey,
      onGenerateRoute: (_) => DashboardData.items[i].screen.route,
    ),
  );

  Future<bool> _onWillPop() async {
    if (await DashboardData.items[_currentIndex].navigatorKey.currentState
            ?.maybePop() ??
        false) {
      AppBarTitle.changeTitle(null);
      return false;
    } else if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: AppBarTitle(_currentIndex),
        ),
        body: AnimatedIndexedStack(
          index: _currentIndex,
          duration: Dashboard.swipeDuration,
          children: _screens,
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              curve: kAnimationCurve,
              duration: kAnimationDuration,
              child: OpenContainer(
                closedElevation: 4,
                openColor: Colours.player,
                middleColor: Colours.player,
                closedColor: Colours.player,
                closedShape: const RoundedRectangleBorder(),
                openBuilder: (_, __) => OpenPlayer(),
                closedBuilder: (_, __) => ClosedPlayer(),
              ),
            ),
            Container(
              color: Colours.bottomNavbar,
              child: Row(
                children: List.generate(
                  DashboardData.items.length,
                  (i) {
                    final item = DashboardData.items[i];
                    return InkWell(
                      onTap: () => setState(() => _currentIndex = i),
                      child: Container(
                        width: Screen.width / DashboardData.items.length,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AnimatedOpacity(
                          curve: kAnimationCurve,
                          opacity: _currentIndex == i ? 1 : 0.46,
                          duration: kAnimationDuration,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                item.iconPath,
                                height: 26,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.name,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
