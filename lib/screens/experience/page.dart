import 'dart:ui' show ImageFilter;
import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/experience/data.dart';

class ExpPage extends StatefulWidget {
  const ExpPage(this.data);
  final ExpTileData data;
  @override
  _ExpPageState createState() => _ExpPageState();
}

class _ExpPageState extends State<ExpPage> {
  late final _stopper = Stopper(300, closeAndPop);
  bool _isBottomSheetOpen = false;
  @override
  void initState() {
    super.initState();
    widget.data.play();
    _stopper
      ..pause()
      ..addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  void dispose() {
    expPlayer.stop();
    super.dispose();
  }

  void closeAndPop() {
    expPlayer.stop();
    audioPlayer.showNotification = true;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.data.imgPath),
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.black54, BlendMode.dstATop),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3,
              sigmaY: 3,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        tooltip: 'Close',
                        onPressed: closeAndPop,
                        padding: const EdgeInsets.all(24.0),
                        iconSize: 28,
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                  const Spacer(flex: 5),
                  Txt.bigTitle(widget.data.name),
                  const Spacer(),
                  Text(
                    _stopper.remainingTime.durationToString,
                    style: const TextStyle(fontSize: 56),
                  ),
                  const Spacer(flex: 2),
                  Container(
                    decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      color: Colors.white30,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Stop',
                          onPressed: closeAndPop,
                          iconSize: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          icon: const Icon(Icons.stop_rounded),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => expPlayer.playOrPause(),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const ShapeDecoration(
                              shadows: [
                                BoxShadow(
                                  color: Colors.white30,
                                  spreadRadius: 12,
                                ),
                              ],
                              shape: CircleBorder(),
                              color: Colors.white,
                            ),
                            child: AnimatedSwitcher(
                              duration: kAnimationDuration * 0.3,
                              switchInCurve: kAnimationCurve,
                              switchOutCurve: kAnimationCurve,
                              child: expPlayer.builderIsPlaying(
                                builder: (_, isPlaying) {
                                  if (_isBottomSheetOpen || !isPlaying) {
                                    _stopper.pause();
                                  } else {
                                    _stopper.play();
                                  }
                                  return Icon(
                                    isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    size: 48,
                                    key: ValueKey('Exp player : $isPlaying'),
                                    color: Colours.scaffold,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Timer',
                          onPressed: () {
                            Duration? temp;
                            _isBottomSheetOpen = true;
                            bottomSheet<Duration>(
                              context,
                              Column(
                                children: [
                                  CupertinoTheme(
                                    data: const CupertinoThemeData(
                                      brightness: Brightness.dark,
                                    ),
                                    child: CupertinoTimerPicker(
                                      initialTimerDuration:
                                          _stopper.remainingTime,
                                      onTimerDurationChanged: (_) => temp = _,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16)
                                              .copyWith(top: 0),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(temp);
                                            },
                                            child: const Txt.bigTitle('Done'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              gradientPercentage: 0.05,
                            ).then((v) {
                              _isBottomSheetOpen = false;
                              _stopper.updateTime(v?.inSeconds);
                            });
                          },
                          iconSize: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          icon: const Icon(Icons.timer_rounded),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
