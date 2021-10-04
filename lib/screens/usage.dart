import 'package:fl_chart/fl_chart.dart';
import '/exporter.dart';

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
              tabs: [
                Tab(text: 'Nap time'),
                Tab(text: 'Sleep time'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(
                  2,
                  (i) => ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(vertical: Dashboard.pad / 2),
                    itemBuilder: (_, i) => i == 0 ? BarGraph() : UsageTile(),
                    itemCount: 16,
                    separatorBuilder: (_, i) => const Divider(
                      height: Dashboard.pad * 2,
                      indent: Dashboard.pad * 4,
                      endIndent: Dashboard.pad * 4,
                    ),
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
  @override
  Widget build(BuildContext context) {
    final count = Random().nextInt(5) + 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dashboard.pad),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Txt.title('28th September 2021'),
                ...const Txt.body('Mix name') * count,
              ],
            ),
          ),
          const Text('2 hr'),
        ],
      ),
    );
  }
}

class BarGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarGraphState();
}

class BarGraphState extends State<BarGraph> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dashboard.pad),
          child: Row(
            children: [
              const Expanded(
                child: Txt.body('Week 30 | 2021'),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_rounded),
              ),
              IconButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                  );
                },
                icon: const Icon(Icons.date_range_rounded),
              ),
            ],
          ),
        ),
        SizedBox(
          width: Screen.width,
          height: Screen.width,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colours.tabUnselected,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String weekDay;
                      switch (group.x.toInt()) {
                        case 0:
                          weekDay = 'Sunday';
                          break;
                        case 1:
                          weekDay = 'Monday';
                          break;
                        case 2:
                          weekDay = 'Tuesday';
                          break;
                        case 3:
                          weekDay = 'Wednesday';
                          break;
                        case 4:
                          weekDay = 'Thursday';
                          break;
                        case 5:
                          weekDay = 'Friday';
                          break;
                        case 6:
                          weekDay = 'Saturday';
                          break;
                        default:
                          weekDay = '';
                          break;
                      }
                      return BarTooltipItem(
                        '$weekDay\n',
                        const TextStyle(color: Colours.elevationButton),
                        children: [
                          TextSpan(
                            text: (rod.y - 1).toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }),
                touchCallback: (flTouchEvent, barTouchResponse) {
                  setState(() {
                    if (!flTouchEvent.isInterestedForInteractions ||
                        barTouchResponse == null ||
                        barTouchResponse.spot == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                  });
                },
              ),
              titlesData: FlTitlesData(
                topTitles: SideTitles(showTitles: false),
                rightTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (_, v) => const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                  margin: 16,
                  getTitles: (v) {
                    switch (v.toInt()) {
                      case 0:
                        return 'Su';
                      case 1:
                        return 'M';
                      case 2:
                        return 'T';
                      case 3:
                        return 'W';
                      case 4:
                        return 'Th';
                      case 5:
                        return 'F';
                      case 6:
                        return 'S';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              barGroups: showingGroups(),
              maxY: 11.5 * 1.2,
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, double y, {bool isTouched = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: [Colours.elevationButton],
          width: 16,
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return makeGroupData(7, 0, isTouched: i == touchedIndex);
        }
      });
}
