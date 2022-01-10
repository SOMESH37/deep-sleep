import 'package:deep_sleep/exporter.dart';
import 'package:fl_chart/fl_chart.dart';

class BarGraph extends StatefulWidget {
  final Box<Map> box;
  const BarGraph(this.box);
  @override
  State<StatefulWidget> createState() => BarGraphState();
}

class BarGraphState extends State<BarGraph> {
  Jiffy selectedDate = Jiffy(DateTime.now());
  late List<BarChartGroupData> data;

  @override
  void initState() {
    super.initState();
    updateData();
  }

  void updateData() {
    final weekStart = selectedDate.clone().startOf(Units.WEEK);
    data = List.generate(
      7,
      (i) {
        final curDate = weekStart.clone().add(days: i).toIntDate;
        final yAxis = widget.box.get(curDate)?['seconds'] as int?;
        return BarChartGroupData(
          x: curDate,
          barRods: [
            BarChartRodData(
              y: yAxis?.toDouble() ?? 0.0,
              colors: [Colours.elevationButton],
              width: 16,
            ),
          ],
        );
      },
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dashboard.pad),
          child: Row(
            children: [
              Expanded(
                child: Txt.body(
                  'Week ${selectedDate.week} | ${selectedDate.year}',
                ),
              ),
              IconButton(
                onPressed: selectedDate
                        .clone()
                        .subtract(weeks: 1)
                        .isAfter(DateTime(2022))
                    ? () {
                        selectedDate.subtract(weeks: 1);
                        updateData();
                      }
                    : null,
                icon: const Icon(Icons.chevron_left_rounded),
                tooltip: 'Previous week',
              ),
              IconButton(
                onPressed: selectedDate.clone().add(weeks: 1).isBefore(Jiffy())
                    ? () {
                        selectedDate.add(weeks: 1);
                        updateData();
                      }
                    : null,
                icon: const Icon(Icons.chevron_right_rounded),
                tooltip: 'Next week',
              ),
              IconButton(
                tooltip: 'Calendar',
                onPressed: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(2022),
                    initialDate: selectedDate.dateTime,
                    lastDate: DateTime.now(),
                  ).then(
                    (v) {
                      if (v != null) {
                        selectedDate = Jiffy(v);
                        updateData();
                      }
                    },
                  );
                },
                icon: const Icon(Icons.date_range_rounded),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: Screen.width,
          height: Screen.width - 24,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                handleBuiltInTouches: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colours.tabUnselected,
                  fitInsideVertically: true,
                  fitInsideHorizontally: true,
                  getTooltipItem: (group, _, rod, __) {
                    return BarTooltipItem(
                      '${Jiffy(group.x.toString()).MMMd}\n',
                      const TextStyle(color: Colours.elevationButton),
                      children: [
                        TextSpan(
                          text: Duration(seconds: rod.y.toInt()).detailedTime,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: SideTitles(showTitles: false),
                leftTitles: SideTitles(showTitles: false),
                rightTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (_, v) => const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                  margin: 16,
                  getTitles: (v) => Jiffy(v.toInt().toString()).E,
                ),
              ),
              barGroups: data,
              gridData: FlGridData(show: false),
            ),
            swapAnimationDuration: Duration.zero,
          ),
        ),
      ],
    );
  }
}
