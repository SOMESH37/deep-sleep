import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/rest/create_mix.dart';
import 'package:deep_sleep/screens/rest/data.dart';

class Rest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const AppTabBar(
            tabs: [
              'Power nap',
              'Good sleep',
              'My space',
            ],
          ),
          Expanded(
            child: ValueListenableBuilder<Box<int>>(
              valueListenable: HiveHelper.downloadStatBox.listenable(),
              builder: (_, downloadBox, __) => TabBarView(
                children: List.generate(
                  3,
                  (i) => i == 2
                      ? MySpaceView(downloadBox)
                      : ListView.separated(
                          padding: const EdgeInsets.all(Dashboard.pad),
                          itemBuilder: (_, j) {
                            return RestTile(
                              i == 0
                                  ? RestTileData.napItems[j]
                                  : RestTileData.sleepItems[j],
                              showIconIf: const {
                                DownloadStatus.notDownloaded,
                                DownloadStatus.downloading,
                              },
                              showSubIf: const {DownloadStatus.downloading},
                            );
                          },
                          itemCount: i == 0
                              ? RestTileData.napItems.length
                              : RestTileData.sleepItems.length,
                          separatorBuilder: (_, i) =>
                              const SizedBox(height: Dashboard.pad),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MySpaceView extends StatelessWidget {
  const MySpaceView(this.downloadBox);
  final Box<int> downloadBox;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<List<String>>>(
      valueListenable: HiveHelper.userMixesBox.listenable(),
      builder: (_, mixBox, __) {
        return ListView.separated(
          padding: const EdgeInsets.all(Dashboard.pad),
          itemCount: downloadBox.keys.length + mixBox.keys.length + 1,
          separatorBuilder: (_, i) => const SizedBox(height: Dashboard.pad),
          itemBuilder: (_, i) {
            if (i == 0) {
              return const RestTile.create();
            } else if (i <= mixBox.keys.length) {
              return RestPlaylistTile(mixBox.keys.toList()[i - 1] as String);
            }
            final data = RestTileData.items.firstWhere(
              (e) =>
                  e.name ==
                  downloadBox.keys.toList()[i - mixBox.keys.length - 1],
            );
            return RestTile(data);
          },
        );
      },
    );
  }
}

class RestPlaylistTile extends StatelessWidget {
  RestPlaylistTile(this.name);
  final String name;
  late final songs = HiveHelper.userMixesBox
      .get(name)!
      .map<Audio>(
        (e) => RestTileData.items
            .firstWhere((ele) => e == ele.name)
            .audio(art: name),
      )
      .toList();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (audioPlayer.isBuffering.value) return;
        audioPlayer.open(
          Playlist(audios: songs),
          showNotification: true,
          loopMode: LoopMode.playlist,
        );
      },
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  songs[i].metas.image!.path,
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation(1 - i * 0.1),
                ),
              ),
              itemCount: min(songs.length, 4),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Txt.title(name),
            ),
          ),
          StreamBuilder<RealtimePlayingInfos?>(
            stream: audioPlayer.realtimePlayingInfos,
            builder: (_, snap) {
              if (snap.data?.current?.audio.audio.metas.artist != name) {
                return const IconButton(
                  onPressed: null,
                  tooltip: 'Play',
                  disabledColor: Colors.white,
                  icon: Icon(Icons.play_arrow_rounded),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          IconButton(
            onPressed: () {
              EditPlaylist(name).push(context, useRootNav: true);
            },
            tooltip: 'Edit',
            icon: const Icon(Icons.edit_rounded),
          ),
        ],
      ),
    );
  }
}

class RestTile extends StatelessWidget {
  RestTile(
    this.data, {
    Set<DownloadStatus>? showSubIf,
    Set<DownloadStatus>? showIconIf,
  })  : status = HiveHelper.downloadStat(data?.name),
        showSub = showSubIf ?? DownloadStatus.values.toSet(),
        showIcon = showIconIf ?? DownloadStatus.values.toSet();

  const RestTile.create()
      : data = null,
        status = null,
        showSub = null,
        showIcon = null;

  final RestTileData? data;
  final DownloadStatus? status;
  final Set<DownloadStatus>? showSub;
  final Set<DownloadStatus>? showIcon;

  String get getSubtitle {
    switch (status) {
      case null:
      case DownloadStatus.notDownloaded:
        return '';
      case DownloadStatus.downloading:
        return 'Downloading | ${HiveHelper.downloadStatBox.get(data?.name)}%';
      case DownloadStatus.downloaded:
        return '${data?.artist}';
    }
  }

  void _onIconPress() {
    switch (status!) {
      case DownloadStatus.notDownloaded:
        data?.download();
        break;
      case DownloadStatus.downloading:
        break;
      case DownloadStatus.downloaded:
        HiveHelper.delete(data!.name);
        break;
    }
  }

  IconData get _icons {
    switch (status!) {
      case DownloadStatus.notDownloaded:
        return Icons.download_rounded;
      case DownloadStatus.downloading:
        return Icons.downloading_rounded;
      case DownloadStatus.downloaded:
        return Icons.delete_forever_rounded;
    }
  }

  String get _tooltips {
    switch (status!) {
      case DownloadStatus.notDownloaded:
        return 'Download';
      case DownloadStatus.downloading:
        return 'Downloading';
      case DownloadStatus.downloaded:
        return 'Delete';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (data != null) {
          data!.play();
        } else {
          CreateMix().push(context, useRootNav: true);
        }
      },
      child: StreamBuilder<Playing?>(
        stream: audioPlayer.current,
        builder: (_, snap) {
          final isPlaying = snap.data?.audio.audio.metas.title == data?.name;
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  data == null ? Assets.splash.path : data!.imgPath,
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: data == null
                      ? const Txt.title('Create mix')
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data!.name,
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    isPlaying ? Colours.elevationButton : null,
                              ),
                            ),
                            if (showSub?.any((e) => e == status) ?? false)
                              Txt.body(getSubtitle),
                          ],
                        ),
                ),
              ),
              if (data != null && !isPlaying)
                const IconButton(
                  onPressed: null,
                  tooltip: 'Play',
                  disabledColor: Colors.white,
                  icon: Icon(Icons.play_arrow_rounded),
                ),
              if (data == null)
                const IconButton(
                  onPressed: null,
                  tooltip: 'Create',
                  disabledColor: Colors.white,
                  icon: Icon(Icons.playlist_add_rounded),
                ),
              if (data != null && (showIcon?.any((e) => e == status) ?? false))
                IconButton(
                  onPressed: _onIconPress,
                  icon: Icon(_icons),
                  tooltip: _tooltips,
                ),
            ],
          );
        },
      ),
    );
  }
}
