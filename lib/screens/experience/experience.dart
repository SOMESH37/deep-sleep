import '/exporter.dart';

class Experience extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const AppTabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Nature'),
              Tab(text: 'Instruments'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(
                3,
                (i) => ListView.separated(
                  padding: const EdgeInsets.all(Dashboard.pad),
                  itemBuilder: (_, i) => const ExperienceTile(),
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

class ExperienceTile extends StatelessWidget {
  const ExperienceTile();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                colorFilter:
                    const ColorFilter.mode(Colors.black45, BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage(Assets.splash.path),
              ),
            ),
          ),
          const Center(
            child: Txt.bigTitle('Name'),
          ),
        ],
      ),
    );
  }
}
