import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/experience/data.dart';
import 'package:deep_sleep/screens/experience/page.dart';

class Experience extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const AppTabBar(
            tabs: [
              'All',
              'Nature',
              'Instruments',
            ],
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(
                3,
                (i) => ListView.separated(
                  padding: const EdgeInsets.all(Dashboard.pad),
                  itemBuilder: (_, j) => i == 0
                      ? ExperienceTile(ExpTileData.items[j])
                      : i == 1
                          ? ExperienceTile(ExpTileData.natures[j])
                          : ExperienceTile(ExpTileData.instruments[j]),
                  itemCount: i == 0
                      ? ExpTileData.items.length
                      : i == 1
                          ? ExpTileData.natures.length
                          : ExpTileData.instruments.length,
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
  const ExperienceTile(this.data);
  final ExpTileData data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ExpPage(data).push(context, useRootNav: true),
      child: SizedBox(
        height: 88,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  colorFilter:
                      const ColorFilter.mode(Colors.black54, BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image: AssetImage(data.imgPath),
                ),
              ),
            ),
            Center(
              child: Txt.bigTitle(data.name),
            ),
          ],
        ),
      ),
    );
  }
}
