import '/exporter.dart';
import 'data.dart';

class Rest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const AppTabBar(
            tabs: [
              Tab(text: 'Power nap'),
              Tab(text: 'Good sleep'),
              Tab(text: 'My space'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(
                3,
                (i) => ListView.separated(
                  padding: const EdgeInsets.all(Dashboard.pad),
                  itemBuilder: (_, j) => i == 2 && j == 0
                      ? const RestTile.create()
                      : RestTile(RestTileData.sleepItems[j]),
                  itemCount: RestTileData.sleepItems.length,
                  separatorBuilder: (_, i) =>
                      const SizedBox(height: Dashboard.pad),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestTile extends StatelessWidget {
  const RestTile(this.data);
  const RestTile.create() : data = null;
  final RestTileData? data;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  AssetImage(data == null ? Assets.splash.path : data!.imgPath),
            ),
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
                      Txt.title(data!.name),
                      const SizedBox(height: 4),
                      // Txt.body('298 plays | 34 min'),
                    ],
                  ),
          ),
        ),
        if (data != null)
          IconButton(
            onPressed: () {},
            icon: Icon(
              data!.downloadStatus == 0
                  ? Icons.download_rounded
                  : data!.downloadStatus == 1
                      ? Icons.downloading_rounded
                      : data!.downloadStatus == 2
                          ? Icons.done_rounded
                          : Icons.delete_forever_rounded,
            ),
            tooltip: data!.downloadStatus == 0
                ? 'Download'
                : data!.downloadStatus == 1
                    ? 'Downloading'
                    : data!.downloadStatus == 2
                        ? 'Downloaded'
                        : 'Delete',
          ),
      ],
    );
  }
}
