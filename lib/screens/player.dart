import '/exporter.dart';

class Player extends StatefulWidget {
  const Player({this.isClosed = false});
  final bool isClosed;
  static const closedProgressHeight = 1.2;
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with TickerProviderStateMixin<Player> {
  final _pad = const EdgeInsets.all(32).copyWith(top: 0);
  late final _animationController = AnimationController(
    vsync: this,
    duration: kAnimationDuration,
  );
  @override
  Widget build(BuildContext context) {
    return widget.isClosed
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 0.6 * Screen.width,
                height: Player.closedProgressHeight,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(Player.closedProgressHeight),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height:
                    Dashboard.openPlayerHeight - Player.closedProgressHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Assets.splash.image(fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Txt.bigTitle(
                            'Mix name',
                            isMarquee: true,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: AnimatedIcon(
                            size: 32,
                            icon: AnimatedIcons.play_pause,
                            progress: _animationController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        iconSize: 28,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert_rounded),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView.builder(
                      itemBuilder: (_, i) => Center(
                        child: Padding(
                          padding: _pad,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Assets.splash.image(fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: _pad,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 33 * Screen.textScaleFactor,
                          child: Txt.bigTitle(
                            'Mix name',
                            isMarquee: true,
                          ),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 2,
                          ),
                          child: Slider(
                            value: 0.2,
                            onChanged: print,
                            inactiveColor: Colors.white30,
                            activeColor: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              iconSize: 48,
                              icon: const Icon(Icons.skip_previous_rounded),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                ),
                                child: AnimatedIcon(
                                  size: 48,
                                  color: Colours.scaffold,
                                  icon: AnimatedIcons.play_pause,
                                  progress: _animationController,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 48,
                              icon: const Icon(Icons.skip_next_rounded),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
