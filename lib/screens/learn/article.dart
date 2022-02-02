import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/learn/data.dart';

class ArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(Dashboard.pad),
      itemCount: ArticlesData.items.length,
      separatorBuilder: (_, i) => const SizedBox(height: Dashboard.pad * 2),
      itemBuilder: (_, i) {
        final item = ArticlesData.items[i];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AppBarTitle.changeTitle('Article');
            ArticleDetail(item).push(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 160,
                margin: const EdgeInsets.only(bottom: Dashboard.pad),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Assets.splash.path),
                  ),
                ),
                child: item.imgLink.netImg,
              ),
              Row(
                children: [
                  Expanded(
                    child: Txt.title(item.title),
                  ),
                  const SizedBox(width: Dashboard.pad / 2),
                  Txt.body('${item.timeToRead}min read'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ArticleDetail extends StatefulWidget {
  const ArticleDetail(this.item);
  final ArticlesData item;

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  WebViewController? controller;
  bool? isLoading = true;

  @override
  Widget build(BuildContext context) {
    // to avoid transparent bg
    return Scaffold(
      body: Stack(
        children: [
          Visibility(
            visible: isLoading == false,
            maintainState: true,
            child: WebView(
              onWebViewCreated: (c) => controller = c,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.item.link,
              onPageStarted: (link) async {
                if (link != widget.item.link) {
                  setState(() => isLoading = true);
                  launch(link);
                  controller?.loadUrl(widget.item.link);
                }
              },
              onPageFinished: (_) {
                // controller?.runJavascript(
                //   "document.body.innerHTML=document.getElementsByTagName('article')[0].lastChild.innerHTML",
                // );
                setState(() => isLoading == true ? isLoading = false : null);
              },
              onWebResourceError: (_) => setState(() => isLoading = null),
            ),
          ),
          if (!(isLoading == false))
            Center(
              child: isLoading == true
                  ? const CircularProgressIndicator(color: Colors.white)
                  : TextButton(
                      onPressed: () {
                        controller?.loadUrl(widget.item.link);
                        setState(() => isLoading = true);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.refresh_rounded,
                            size: 40,
                          ),
                          Txt.body('Try again'),
                        ],
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
