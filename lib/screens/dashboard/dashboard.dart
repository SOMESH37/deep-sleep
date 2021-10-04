import '/exporter.dart';
import 'data.dart';
import 'drawer.dart';

class Dashboard extends StatefulWidget {
  static const pad = 16.0;
  static const openPlayerHeight = 56.0;
  static late void Function(String?) changeTitle;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with TickerProviderStateMixin<Dashboard> {
  var _currentIndex = 0;
  String? _title;
  final _swipeDuration = kAnimationDuration * 0.4;
  late final _animationController = AnimationController(
    vsync: this,
    duration: kAnimationDuration,
  );
  final _screens = List.generate(
    DashboardData.items.length,
    (i) => Navigator(
      key: DashboardData.items[i].navigatorKey,
      onGenerateRoute: (_) => DashboardData.items[i].screen.route,
    ),
  );
  final _titles = List.generate(
    DashboardData.items.length,
    (i) => Text(DashboardData.items[i].appBarTitle),
  );

  void changeTitle(String? t) => setState(() => _title = t);

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
    Dashboard.changeTitle = changeTitle;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Builder(
            builder: (c) {
              final nav =
                  DashboardData.items[_currentIndex].navigatorKey.currentState!;
              if (nav.canPop()) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              return Row(
                children: [
                  SizedBox(
                    height: 56,
                    width: 56,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        if (_animationController.isAnimating) return;
                        if (await nav.maybePop()) {
                          if (!nav.canPop()) {
                            changeTitle(null);
                            _animationController.reverse();
                          }
                        } else {
                          Scaffold.of(c).openDrawer();
                        }
                      },
                      child: Center(
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_arrow,
                          progress: _animationController,
                        ),
                      ),
                    ),
                  ),
                  AnimatedIndexedStack(
                    index: _title != null && nav.canPop()
                        ? DashboardData.items.length
                        : _currentIndex,
                    duration: _swipeDuration,
                    type: AnimatedIndexedStackType.horizontal,
                    children: [
                      ..._titles,
                      Text(_title ?? ''),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        body: AnimatedIndexedStack(
          index: _currentIndex,
          duration: _swipeDuration,
          children: _screens,
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              curve: kAnimationCurve,
              duration: kAnimationDuration,
              vsync: this,
              child: OpenContainer(
                closedElevation: 4,
                openColor: Colours.player,
                middleColor: Colours.player,
                closedColor: Colours.player,
                closedShape: const RoundedRectangleBorder(),
                openBuilder: (_, __) => const Player(),
                closedBuilder: (_, action) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: action,
                  child: SizedBox(
                    height: false ? 0.0 : Dashboard.openPlayerHeight,
                    child: const Player(isClosed: true),
                  ),
                ),
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
                      child: AnimatedSize(
                        curve: kAnimationCurve,
                        duration: kAnimationDuration,
                        vsync: this,
                        child: Container(
                          width: Screen.width / DashboardData.items.length,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedOpacity(
                                curve: kAnimationCurve,
                                opacity: _currentIndex == i ? 1 : 0.5,
                                duration: kAnimationDuration,
                                child: SvgPicture.asset(
                                  item.iconPath,
                                  height: _currentIndex == i ? 32 : 24,
                                ),
                              ),
                              if (_currentIndex != i) const SizedBox(height: 4),
                              if (_currentIndex != i)
                                Text(
                                  item.name,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.white70),
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
