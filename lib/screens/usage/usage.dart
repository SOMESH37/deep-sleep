import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/usage/bar_graph.dart';

class Usage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usage'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const AppTabBar(
              tabs: ['Rest', 'Experience'],
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(
                  2,
                  (i) => ValueListenableBuilder<Box<Map>>(
                    valueListenable: i == 0
                        ? HiveHelper.restUsageBox.listenable()
                        : HiveHelper.experienceUsageBox.listenable(),
                    builder: (_, box, __) {
                      final list = box.values
                          .map(UsageTileData.fromMap)
                          .toList()
                        ..sort((a, b) => b.date.compareTo(a.date));
                      return list.isEmpty
                          ? const Center(
                              child: Text('Play some music'),
                            )
                          : ListView.separated(
                              padding: EdgeInsets.only(
                                top: Dashboard.pad / 2,
                                bottom: Dashboard.pad / 2 +
                                    Screen.bottomSafeAreaPadding,
                              ),
                              itemBuilder: (_, j) {
                                return j == 0
                                    ? BarGraph(box)
                                    : UsageTile(list[j - 1]);
                              },
                              itemCount: list.length + 1,
                              separatorBuilder: (_, i) => const Divider(
                                height: Dashboard.pad * 2,
                                indent: Dashboard.pad * 4,
                                endIndent: Dashboard.pad * 4,
                              ),
                            );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsageTile extends StatelessWidget {
  final UsageTileData data;
  const UsageTile(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dashboard.pad),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt.title(Jiffy(data.date.toString()).yMMMMd),
                ...data.names.map(Txt.body),
              ],
            ),
          ),
          Text(Duration(seconds: data.seconds).detailedTime),
        ],
      ),
    );
  }
}

class UsageTileData {
  int seconds;
  int lastSavedTimeSec;
  final int date;
  Set<String> names;

  UsageTileData({
    required this.date,
    required this.names,
    required this.seconds,
    required this.lastSavedTimeSec,
  });

  Map<String, dynamic> toMap() => {
        'date': date,
        'names': names.toList(),
        'seconds': seconds,
        'last_saved_time_sec': lastSavedTimeSec,
      };

  factory UsageTileData.fromMap(Map map) => UsageTileData(
        date: map['date'] as int,
        seconds: map['seconds'] as int,
        names: Set<String>.from(map['names'] as Iterable),
        lastSavedTimeSec: map['last_saved_time_sec'] as int,
      );
}
