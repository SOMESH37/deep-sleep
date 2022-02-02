import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/dashboard/data.dart';

class AppBarTitle extends StatefulWidget {
  const AppBarTitle(this.currentIndex);
  final int currentIndex;

  static late void Function(String?) changeTitle;
  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle>
    with TickerProviderStateMixin<AppBarTitle> {
  String? _title;
  late final _animationController = AnimationController(
    vsync: this,
    duration: kAnimationDuration,
  );
  final _titles = List.generate(
    DashboardData.items.length,
    (i) => Text(DashboardData.items[i].appBarTitle),
  );

  void changeTitle(String? t) => setState(() => _title = t);

  @override
  void initState() {
    super.initState();
    AppBarTitle.changeTitle = changeTitle;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav =
        DashboardData.items[widget.currentIndex].navigatorKey.currentState!;
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
                Scaffold.of(context).openDrawer();
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
              : widget.currentIndex,
          duration: Dashboard.swipeDuration,
          type: AnimatedIndexedStackType.horizontal,
          children: [
            ..._titles,
            Text(_title ?? ''),
          ],
        ),
      ],
    );
  }
}
