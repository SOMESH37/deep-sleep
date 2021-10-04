import '/exporter.dart';

class ForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: Dashboard.pad),
      children: [
        const Padding(
          padding: EdgeInsets.all(Dashboard.pad),
          child: Txt.head('Downloads'),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              6,
              (i) => i == 0
                  ? const SizedBox(width: Dashboard.pad)
                  : const ForYouTile(),
            ),
          ),
        ),
        const SizedBox(height: Dashboard.pad),
        const Padding(
          padding: EdgeInsets.all(Dashboard.pad),
          child: Txt.head('Recently played'),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              6,
              (i) => i == 0
                  ? const SizedBox(width: Dashboard.pad)
                  : const ForYouTile(),
            ),
          ),
        ),
        const SizedBox(height: Dashboard.pad),
        const Padding(
          padding: EdgeInsets.all(Dashboard.pad),
          child: Txt.head('Recommended'),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              6,
              (i) => i == 0
                  ? const SizedBox(width: Dashboard.pad)
                  : const ForYouTile.wide(),
            ),
          ),
        ),
      ],
    );
  }
}

class ForYouTile extends StatelessWidget {
  const ForYouTile()
      : height = 220,
        width = 140;
  const ForYouTile.wide()
      : height = 180,
        width = 300;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Dashboard.pad),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Assets.splash.image(
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: Dashboard.pad / 2),
            child: Txt.title('Mix name'),
          ),
          const Txt.body('Power nap | 34mins'),
        ],
      ),
    );
  }
}
