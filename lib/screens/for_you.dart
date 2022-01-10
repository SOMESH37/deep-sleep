import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/rest/data.dart';

class ForYou extends StatelessWidget {
  final startIndexAll = Random().nextInt(RestTileData.items.length - 5);
  final startIndexNap = Random().nextInt(RestTileData.napItems.length - 4);
  final startIndexSleep = Random().nextInt(RestTileData.sleepItems.length - 3);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ValueListenableBuilder<Box<int>>(
          valueListenable: HiveHelper.downloadStatBox.listenable(),
          builder: (_, box, __) {
            final list = (box.toMap()..removeWhere((_, v) => v <= 100))
                .keys
                .map(
                  (e) => RestTileData.items.firstWhere((ele) => ele.name == e),
                )
                .toList();
            if (list.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return ForYouTile(title: 'Downloads', data: list);
            }
          },
        ),
        ForYouTile(
          title: 'Recommended',
          data: RestTileData.items.sublist(startIndexAll, startIndexAll + 5),
        ),
        ForYouTile.wide(
          title: 'Break time',
          data: RestTileData.napItems.sublist(startIndexNap, startIndexNap + 4),
        ),
        ForYouTile.wide(
          title: 'Sleepy night',
          data: RestTileData.sleepItems
              .sublist(startIndexSleep, startIndexSleep + 3),
        ),
      ],
    );
  }
}

class ForYouTile extends StatelessWidget {
  const ForYouTile({
    required this.title,
    required this.data,
  })  : height = 220,
        width = 140;
  const ForYouTile.wide({
    required this.title,
    required this.data,
  })  : height = 180,
        width = 300;

  final double height;
  final double width;
  final String title;
  final List<RestTileData> data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dashboard.pad),
          child: Txt.head(title),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(
            bottom: Dashboard.pad,
            left: Dashboard.pad,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              data.length,
              (i) {
                final item = data[i];
                return LimitedBox(
                  maxWidth: width,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: item.play,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: height,
                          margin: const EdgeInsets.only(right: Dashboard.pad),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(item.imgPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: StreamBuilder<Playing?>(
                            stream: audioPlayer.current,
                            builder: (_, snap) {
                              final isPlaying =
                                  snap.data?.audio.audio.metas.title ==
                                      item.name;
                              return isPlaying
                                  ? const SizedBox.shrink()
                                  : FractionallySizedBox(
                                      widthFactor: .44,
                                      heightFactor: .44,
                                      child: Container(
                                        decoration: const ShapeDecoration(
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.white10,
                                              spreadRadius: 10,
                                            ),
                                          ],
                                          shape: CircleBorder(),
                                          color: Colors.white30,
                                        ),
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          size: width / 4,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ),
                        const SizedBox(height: Dashboard.pad / 2),
                        Txt.title(item.name),
                        Txt.body(item.artist),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
