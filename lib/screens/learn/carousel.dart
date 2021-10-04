import '/exporter.dart';

class ImageSwipe extends StatelessWidget {
  const ImageSwipe.tip() : _isTip = true;
  const ImageSwipe.terminology() : _isTip = false;
  final bool _isTip;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemBuilder: (_, i, __) => Stack(
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
                    image: AssetImage(Assets.splash.path),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all((_isTip ? 1 : 1.6) * Dashboard.pad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isTip) const Txt.bigTitle('Name'),
                    if (!_isTip) const SizedBox(height: Dashboard.pad),
                    Text(
                      'Aliqua nostrud enim sit officia. Non ad et id pariatur minim enim nulla.',
                      style: TextStyle(fontSize: _isTip ? 40 : 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          itemCount: 6,
          options: CarouselOptions(
            height: Screen.height - 250 - Dashboard.openPlayerHeight,
            viewportFraction: _isTip ? 0.75 : 0.85,
            enlargeCenterPage: true,
            autoPlay: _isTip,
          ),
        ),
      ],
    );
  }
}
