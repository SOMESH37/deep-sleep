import '/exporter.dart';

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
                      : const RestTile(),
                  itemCount: 16,
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
  const RestTile() : _isCreate = false;
  const RestTile.create() : _isCreate = true;
  final bool _isCreate;
  @override
  Widget build(BuildContext context) {
    final icon = Random().nextInt(4);
    return Row(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Assets.splash.path),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _isCreate
                ? const Txt.title('Create mix')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Txt.title('Mix name'),
                      SizedBox(height: 4),
                      Txt.body('298 plays | 34 min'),
                    ],
                  ),
          ),
        ),
        if (!_isCreate)
          IconButton(
            onPressed: () {},
            icon: Icon(
              icon == 0
                  ? Icons.download_rounded
                  : icon == 1
                      ? Icons.downloading_rounded
                      : icon == 2
                          ? Icons.done_rounded
                          : Icons.delete_forever_rounded,
            ),
            tooltip: icon == 0
                ? 'Download'
                : icon == 1
                    ? 'Downloading'
                    : icon == 2
                        ? 'Downloaded'
                        : 'Delete',
          ),
      ],
    );
  }
}
