import '/exporter.dart';

final _pad = const EdgeInsets.all(32).copyWith(top: 0);
final _playerDuration = kAnimationDuration * 0.3;
const _smallIconSize = 32.0;
late final AssetsAudioPlayer audioPlayer;

//   open(
//     Playlist(audios: List.generate(
//   RestTileData.sleepItems.length,
//   (i) {
//     final item = RestTileData.sleepItems[i];
//     return Audio.network(
//       item.source,
//       cached: true,
//       metas: Metas(
//         title: item.name,
//         artist: 'Good sleep',
//         image: MetasImage.asset(item.imgPath),
//       ),
//     );
//   },
// ),
//     autoStart: false,
//     showNotification: true,
//     notificationSettings: const NotificationSettings(stopEnabled: false),
//   );

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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Txt.bigTitle(
                          data.title!,
                          isMarquee: true,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => audioPlayer.playOrPause(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: _playerDuration,
                          switchInCurve: kAnimationCurve,
                          switchOutCurve: kAnimationCurve,
                          child: Icon(
                            info.isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 32,
                            key: UniqueKey(),
                          ),
                        ),
                      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: audioPlayer.builderRealtimePlayingInfos(builder: (_, info) {
          if (info.current == null) {
            return const SizedBox.shrink();
          }
          final data = info.current!.audio.audio;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    iconSize: 28,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert_rounded,
                    ),
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
                          child: Image.asset(
                            data.metas.image!.path,
                            fit: BoxFit.cover,
                          ),
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
                        data.metas.title!,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          iconSize: _smallIconSize * 0.7,
                          icon: data.playSpeed == 1
                              ? const Icon(Icons.speed_rounded)
                              : Text(
                                  '${data.playSpeed}x',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colours.elevationButton,
                                  ),
                                ),
                        ),
                        IconButton(
                          onPressed: () {},
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
                                true
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 48,
                                key: UniqueKey(),
                                color: Colours.scaffold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          iconSize: _smallIconSize,
                          icon: const Icon(
                            CupertinoIcons.goforward_15,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          iconSize: _smallIconSize * 0.7,
                          color: true ? null : Colours.elevationButton,
                          icon: const Icon(
                            CupertinoIcons.moon_zzz_fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
