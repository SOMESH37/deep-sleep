import '/exporter.dart';

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
  final _data = <_OnboardData>[
    _OnboardData(
      title: 'In Deep Sleep You',
      description: 'Listen to calming ASMR sounds',
      image: Assets.onboardOne.image(height: _imgHeight),
    ),
    _OnboardData(
      title: 'And',
      description: 'Create your own mix',
      image: Assets.onboardTwo.image(height: _imgHeight),
    ),
    _OnboardData(
      title: 'To',
      description: 'Sleep Well',
      image: Assets.onboardThree.image(height: _imgHeight),
    ),
  ];
  void toLogin() => Login().push(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _current = i),
            itemCount: _data.length,
            itemBuilder: (_, i) {
              final temp = _data[i];
              return Center(
                child: SizedBox(
                  height: Screen.height * 0.6,
                  width: Screen.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Center(child: temp.image),
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
                      _data.length,
                      (idx) => Container(
                        width: _current == idx ? 8.0 : 6.4,
                        height: _current == idx ? 8.0 : 6.4,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                                .withOpacity(_current == idx ? 0.9 : 0.3)),
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
                if (_current == _data.length - 1) {
                  toLogin();
                } else {
                  _controller.nextPage(
                      duration: kAnimationDuration, curve: kAnimationCurve);
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 40),
                  primary:
                      _current == _data.length - 1 ? null : Colors.transparent),
              child: Row(
                children: [
                  Text(
                    _current == _data.length - 1 ? 'Start' : 'Next',
                    style: const TextStyle(fontSize: 18),
                  ),
                  ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 18),
                      child: const Icon(Icons.chevron_right_rounded)),
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
  String title;
  String description;
  Image image;
  _OnboardData({
    required this.title,
    required this.description,
    required this.image,
  });
}
