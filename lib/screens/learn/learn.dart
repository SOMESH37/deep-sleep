import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/learn/article.dart';
import 'package:deep_sleep/screens/learn/carousel.dart';

class Learn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const AppTabBar(
            tabs: [
              Tab(text: 'Tips'),
              Tab(text: 'Articles'),
              Tab(text: 'Terminology'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                const ImageSwipe.tip(),
                ArticleList(),
                const ImageSwipe.terminology(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
