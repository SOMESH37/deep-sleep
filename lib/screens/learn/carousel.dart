import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/learn/data.dart';

class ImageSwipe extends StatelessWidget {
  const ImageSwipe.tip() : isTips = true;
  const ImageSwipe.terminology() : isTips = false;
  final bool isTips;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: (isTips ? 2 : 1.6) * Dashboard.pad),
      child: CarouselSlider.builder(
        itemBuilder: (_, i, __) {
          final item = isTips ? TipsData.items[i] : TerminologyData.items[i];
          return GestureDetector(
            onTap: () {
              if (isTips) {
                launch((item as TipsData).link);
              } else {
                AppBarTitle.changeTitle('Terminology');
                TerminologyView(item as TerminologyData).push(context);
              }
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white10,
                        Colors.black87,
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Assets.sceneries[i % Assets.sceneries.length],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    (isTips ? 2 : 1.6) * Dashboard.pad,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: isTips
                        ? [
                            AutoSizeText(
                              (item as TipsData).tip.toLowerCase().capitalize,
                              maxLines: 4,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]
                        : [
                            Txt.bigTitle((item as TerminologyData).title),
                            const SizedBox(height: Dashboard.pad),
                            AutoSizeText(
                              item.body,
                              maxLines: 5,
                              minFontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount:
            isTips ? TipsData.items.length : TerminologyData.items.length,
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: isTips ? 0.75 : 0.85,
          enlargeCenterPage: true,
          autoPlay: isTips,
        ),
      ),
    );
  }
}

class TerminologyView extends StatelessWidget {
  const TerminologyView(this.item);
  final TerminologyData item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dashboard.pad),
            child: Text(
              item.title,
              style: const TextStyle(
                fontSize: 24,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dashboard.pad),
            child: Text(item.body),
          ),
          Padding(
            padding: const EdgeInsets.all(Dashboard.pad),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => launch(item.link),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: const [
                        Icon(Icons.open_in_new_rounded),
                        Text('  Read more'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
