part of 'player.dart';

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
