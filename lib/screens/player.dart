import 'package:deep_sleep/exporter.dart';

const _pad = EdgeInsets.all(32);
final _playerDuration = kAnimationDuration * 0.3;
const _smallIconSize = 32.0;
Stopper? _stopper;
late AssetsAudioPlayer audioPlayer;
late AssetsAudioPlayer expPlayer;

void closeAudioPlayer() {
  audioPlayer
    ..setPlaySpeed(1)
    ..stop();
  _stopper = null;
}

class ClosedPlayer extends StatefulWidget {
  static const closedProgressHeight = 1.2;
  @override
  _ClosedPlayerState createState() => _ClosedPlayerState();
}

class _ClosedPlayerState extends State<ClosedPlayer> {
  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderRealtimePlayingInfos(
      builder: (_, info) {
        if (info.current == null) {
          return const SizedBox.shrink();
        }
        final data = info.current!.audio.audio.metas;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: kAnimationDuration,
              curve: kAnimationCurve,
              width: info.playingPercent * Screen.width,
              height: ClosedPlayer.closedProgressHeight,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(
                      ClosedPlayer.closedProgressHeight,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dashboard.openPlayerHeight -
                  ClosedPlayer.closedProgressHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      data.image!.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Txt.bigTitle(
                          data.title!,
                          isMarquee: true,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => audioPlayer.playOrPause(),
                    icon: AnimatedSwitcher(
                      duration: _playerDuration,
                      switchInCurve: kAnimationCurve,
                      switchOutCurve: kAnimationCurve,
                      child: Icon(
                        info.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 32,
                        key: ValueKey('Closed player : ${info.isPlaying}'),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30,
                      ),
                      onPressed: closeAudioPlayer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class OpenPlayer extends StatefulWidget {
  @override
  _OpenPlayerState createState() => _OpenPlayerState();
}

class _OpenPlayerState extends State<OpenPlayer> {
  Color? imgColor;
  String? currentImgPath;

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderRealtimePlayingInfos(
      builder: (_, info) {
        if (info.current == null) {
          Future.delayed(
            const Duration(milliseconds: 4),
            () => Navigator.maybePop(context),
          );
          return const SizedBox.shrink();
        }
        final data = info.current!.audio.audio;
        final imgPath = data.metas.image!.path;
        if (currentImgPath != imgPath) {
          currentImgPath = imgPath;
          PaletteGenerator.fromImageProvider(AssetImage(imgPath)).then(
            (v) => mounted
                ? setState(() => imgColor = v.dominantColor?.color)
                : null,
          );
        }
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                imgColor ?? Colours.scaffold,
                Colours.scaffold,
                Colours.scaffold,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        tooltip: 'Hide player',
                        iconSize: 28,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: _pad.copyWith(top: 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 33 * Screen.textScaleFactor,
                          child: Txt.bigTitle(
                            data.metas.title!,
                            isMarquee: true,
                          ),
                        ),
                        Txt.body(data.metas.artist!),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    data.metas.image!.path,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PositionSeekWidget(
                  currentPosition: info.currentPosition,
                  duration: info.duration,
                  seekTo: audioPlayer.seek,
                ),
                Padding(
                  padding: _pad.copyWith(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      audioPlayer.builderPlaySpeed(
                        builder: (_, speed) => IconButton(
                          tooltip: 'Playback speed',
                          onPressed: () {
                            bottomSheet(
                              context,
                              Column(
                                children: [
                                  const Padding(
                                    padding: _pad,
                                    child: Center(
                                      child: Txt.bigTitle(
                                        'Change speed',
                                      ),
                                    ),
                                  ),
                                  ...{0.5, 0.8, 1, 1.2, 1.5, 1.8, 2}
                                      .map(
                                        (e) => ListTile(
                                          trailing: speed == e
                                              ? const Icon(
                                                  Icons.check_rounded,
                                                  color:
                                                      Colours.elevationButton,
                                                )
                                              : null,
                                          title: Text(
                                            '${e}x',
                                            style: speed == e
                                                ? const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colours.elevationButton,
                                                  )
                                                : const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                          ),
                                          onTap: () => Navigator.pop(
                                            context,
                                            e.toDouble(),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            ).then(
                              (v) => v is double
                                  ? audioPlayer.setPlaySpeed(v)
                                  : null,
                            );
                          },
                          iconSize: _smallIconSize * 0.7,
                          icon: speed == 1
                              ? const Icon(Icons.speed_rounded)
                              : Text(
                                  '${speed}x',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colours.elevationButton,
                                  ),
                                ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Seek 15 seconds backward',
                        onPressed: () {
                          audioPlayer.seekBy(const Duration(seconds: -15));
                        },
                        iconSize: _smallIconSize,
                        icon: const Icon(
                          CupertinoIcons.gobackward_15,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => audioPlayer.playOrPause(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.white,
                          ),
                          child: AnimatedSwitcher(
                            duration: _playerDuration,
                            switchInCurve: kAnimationCurve,
                            switchOutCurve: kAnimationCurve,
                            child: Icon(
                              info.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: 48,
                              key: ValueKey('Open player : ${info.isPlaying}'),
                              color: Colours.scaffold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Seek 15 seconds forward',
                        onPressed: () {
                          audioPlayer.seekBy(const Duration(seconds: 15));
                        },
                        iconSize: _smallIconSize,
                        icon: const Icon(
                          CupertinoIcons.goforward_15,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Sleep timer',
                        onPressed: () {
                          bottomSheet(
                            context,
                            Column(
                              children: [
                                const Padding(
                                  padding: _pad,
                                  child: Center(
                                    child: Txt.bigTitle(
                                      'Stop audio in',
                                    ),
                                  ),
                                ),
                                if (_stopper?.isActive ?? false)
                                  ListTile(
                                    title: Text(
                                      'Turn off timer (${_stopper!.remainingTime.inMinutes} minutes left)',
                                      style: const TextStyle(
                                        color: Colours.elevationButton,
                                      ),
                                    ),
                                    onTap: () {
                                      _stopper?.dispose();
                                      _stopper = null;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ...{10, 15, 30, 60, 90}
                                    .map(
                                      (e) => ListTile(
                                        title: Text('$e minutes'),
                                        onTap: () {
                                          if (_stopper == null) {
                                            _stopper = Stopper(
                                              e * 60,
                                              closeAudioPlayer,
                                            );
                                          } else {
                                            _stopper!.updateTime(e * 60);
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                          ).then((_) => setState(() {}));
                        },
                        iconSize: _smallIconSize * 0.7,
                        color: _stopper?.isActive ?? false
                            ? Colours.elevationButton
                            : null,
                        icon: const Icon(
                          CupertinoIcons.moon_zzz_fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration _visibleValue = widget.currentPosition;
  bool listenOnlyUserInteraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInteraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SliderTheme(
            data: const SliderThemeData(trackHeight: 2),
            child: Slider(
              inactiveColor: Colors.white30,
              activeColor: Colors.white,
              max: widget.duration.inMilliseconds.toDouble(),
              value: percent.clamp(0.0, 1.0) * widget.duration.inMilliseconds,
              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInteraction = false;
                  widget.seekTo(_visibleValue);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInteraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  _visibleValue = Duration(milliseconds: newValue.floor());
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt.body(widget.currentPosition.durationToString),
                Txt.body(widget.duration.durationToString),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
