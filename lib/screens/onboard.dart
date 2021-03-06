import 'package:deep_sleep/exporter.dart';

class OnBoard extends StatefulWidget {
  const OnBoard();
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  var _current = 0;
  final _pad = 16.0;
  late final _controller = PageController();
  static final _imgHeight = Screen.width * 0.7;

  void toLogin() => Login().push(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _current = i),
            itemCount: _OnboardData.items.length,
            itemBuilder: (_, i) {
              final temp = _OnboardData.items[i];
              return Center(
                child: SizedBox(
                  height: Screen.height * 0.6,
                  width: Screen.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Center(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32),
                          ),
                          child: temp.image.image(
                            height: _imgHeight,
                            width: _imgHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(_pad),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              temp.title,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              temp.description,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: Screen.height * 0.1,
            left: _pad,
            right: _pad,
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _OnboardData.items.length,
                      (idx) => Container(
                        width: _current == idx ? 8.0 : 6.4,
                        height: _current == idx ? 8.0 : 6.4,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                              .withOpacity(_current == idx ? 0.9 : 0.3),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: toLogin,
                    child: const Text('Skip'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: Screen.height * 0.8,
            right: _pad,
            child: ElevatedButton(
              onPressed: () {
                if (_current == _OnboardData.items.length - 1) {
                  toLogin();
                } else {
                  _controller.nextPage(
                    duration: kAnimationDuration,
                    curve: kAnimationCurve,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(80, 40),
                primary: _current == _OnboardData.items.length - 1
                    ? null
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  if (_current == _OnboardData.items.length - 1)
                    const Text('Start', style: TextStyle(fontSize: 18))
                  else
                    const Text('Next', style: TextStyle(fontSize: 18)),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 18),
                    child: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardData {
  final String title;
  final String description;
  final AssetGenImage image;
  const _OnboardData({
    required this.title,
    required this.description,
    required this.image,
  });
  static const items = [
    _OnboardData(
      title: 'In Deep Sleep You',
      description: 'Listen to calming ASMR sounds',
      image: Assets.scenery10,
    ),
    _OnboardData(
      title: 'And',
      description: 'Create your own mix',
      image: Assets.scenery1,
    ),
    _OnboardData(
      title: 'To',
      description: 'Sleep Well',
      image: Assets.scenery16,
    ),
  ];
}
