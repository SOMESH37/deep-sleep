import 'package:marquee/marquee.dart';
import '/exporter.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({required this.tabs});
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: Dashboard.pad)
          .copyWith(bottom: 4),
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: Colours.tabUnselected,
      ),
      child: TabBar(
        tabs: tabs,
        indicatorWeight: 0,
        enableFeedback: false,
        indicator: const ShapeDecoration(
          shape: StadiumBorder(),
          color: Colours.tabSelected,
        ),
      ),
    );
  }
}

class Txt extends StatelessWidget {
  const Txt.head(this.text, {this.isMarquee = false})
      : style = const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        );
  const Txt.bigTitle(this.text, {this.isMarquee = false})
      : style = const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        );
  const Txt.title(this.text, {this.isMarquee = false})
      : style = const TextStyle(fontSize: 18);
  const Txt.body(this.text, {this.isMarquee = false})
      : style = const TextStyle(
          fontSize: 14,
          color: Colors.white70,
        );

  final String text;
  final TextStyle style;
  final bool isMarquee;
  @override
  Widget build(BuildContext context) {
    return isMarquee
        ? AutoSizeText(
            text,
            style: style,
            maxLines: 1,
            maxFontSize: style.fontSize!,
            minFontSize: style.fontSize!,
            overflowReplacement: Marquee(
              text: text,
              style: style,
              blankSpace: 64,
              velocity: 32,
              startAfter: const Duration(seconds: 2),
              pauseAfterRound: const Duration(seconds: 2),
            ),
          )
        : Text(
            text,
            style: style,
          );
  }
}

enum AnimatedIndexedStackType { horizontal, vertical }

class AnimatedIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;
  final AnimatedIndexedStackType type;
  const AnimatedIndexedStack({
    required this.index,
    required this.children,
    this.type = AnimatedIndexedStackType.vertical,
    this.duration = kAnimationDuration,
  });
  @override
  _AnimatedIndexedStackState createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack>
    with SingleTickerProviderStateMixin<AnimatedIndexedStack> {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final _animation = Tween(begin: 1.0, end: 0.05).animate(
    CurvedAnimation(
      parent: _controller,
      curve: kAnimationCurve,
    ),
  );
  late int _index;
  bool _rtl = true;
  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }

  @override
  void didUpdateWidget(AnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != _index) {
      _rtl = widget.index > _index;
      _controller.forward().then((_) {
        setState(() => _index = widget.index);
        _controller.reverse();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (c, child) {
          final Offset offset;
          switch (widget.type) {
            case AnimatedIndexedStackType.horizontal:
              offset = Offset(
                (1 - _animation.value) *
                    24 *
                    (_rtl == _controller.velocity < 0 ? 1 : -1),
                0,
              );
              break;
            case AnimatedIndexedStackType.vertical:
              offset = Offset(
                0,
                (1 - _animation.value) *
                    6 *
                    (_controller.velocity < 0 ? 1 : -1),
              );
              break;
          }
          return Transform.translate(
            offset: offset,
            child: child,
          );
        },
        child: IndexedStack(
          index: _index,
          children: widget.children,
        ),
      ),
    );
  }
}
