part of 'player.dart';

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
                SizedBox(
                  height: 33 * Screen.textScaleFactor,
                  child: Txt.bigTitle(
                    data.metas.title!,
                    isMarquee: true,
                  ),
                ),
                Txt.body(data.metas.artist!),
                Expanded(
                  child: IgnorePointer(
                    ignoring: info.isBuffering,
                    child: PageView.builder(
                      key: ValueKey('PageView : ${info.current.hashCode}'),
                      onPageChanged: audioPlayer.playlistPlayAtIndex,
                      itemCount: info.current!.playlist.audios.length,
                      controller: PageController(
                        initialPage: info.current!.playlist.currentIndex,
                      ),
                      itemBuilder: (_, i) => Padding(
                        padding: _pad,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                info.current!.playlist.audios[i].metas.image!
                                    .path,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                                ...{5, 10, 15, 30, 60, 90}
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
