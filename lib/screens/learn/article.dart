import '/exporter.dart';

class ArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(Dashboard.pad),
      itemCount: 11,
      separatorBuilder: (_, i) => const SizedBox(height: Dashboard.pad * 2),
      itemBuilder: (_, i) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          ArticleDetail(i).push(context);
          Dashboard.changeTitle('Article $i');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 160,
              margin: const EdgeInsets.only(bottom: Dashboard.pad),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(Assets.splash.path),
                ),
              ),
            ),
            Row(
              children: const [
                Expanded(
                  child: Txt.title('Heading'),
                ),
                SizedBox(width: Dashboard.pad / 2),
                Txt.body('3min read'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleDetail extends StatelessWidget {
  ArticleDetail(this.i);
  final int i;
  late final _controller = PageController(initialPage: i);
  @override
  Widget build(BuildContext context) {
    // to avoid transparent bg
    return Scaffold(
      body: PageView.builder(
        onPageChanged: (_) {
          Dashboard.changeTitle('Article $_');
        },
        controller: _controller,
        itemCount: 11,
        itemBuilder: (_, i) => ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(Dashboard.pad),
              child: Text(
                'Ea aliquip laboris esse nostrud commodo veniam voluptate proident.',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: Screen.width,
              height: Screen.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(Assets.splash.path),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(Dashboard.pad),
              child: Text(
                '''Excepteur reprehenderit id in irure amet dolor quis eu ipsum nostrud mollit. Eu cupidatat Lorem deserunt nisi eiusmod incididunt velit id. Eu aute ea aliqua fugiat labore et aliqua aliqua amet ea esse eu officia. Fugiat incididunt aliquip cupidatat cillum adipisicing nulla. Enim nulla nostrud aute culpa amet do commodo fugiat dolore. Dolore esse minim excepteur minim elit est commodo deserunt. Duis voluptate velit nulla duis voluptate ea consequat mollit adipisicing occaecat ut do voluptate. Tempor ut irure et laboris anim elit. Pariatur mollit irure dolore cupidatat ex nulla aute qui. Id ad non exercitation est. Commodo elit esse consectetur pariatur minim id incididunt in pariatur voluptate tempor ipsum. Tempor voluptate labore labore anim ad aliquip officia eiusmod cillum culpa pariatur sint. Incididunt est elit dolore ullamco. Nisi ad cupidatat commodo proident cillum est in elit laboris. Culpa occaecat dolor laborum exercitation nostrud et officia. Deserunt consectetur ullamco exercitation eiusmod duis elit veniam amet Lorem elit anim nulla. Duis cillum ut incididunt mollit tempor.''',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
