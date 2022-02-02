part of 'player.dart';

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration _visibleValue = widget.currentPosition;
  bool listenOnlyUserInteraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInteraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SliderTheme(
            data: const SliderThemeData(trackHeight: 2),
            child: Slider(
              inactiveColor: Colors.white30,
              activeColor: Colors.white,
              max: widget.duration.inMilliseconds.toDouble(),
              value: percent.clamp(0.0, 1.0) * widget.duration.inMilliseconds,
              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInteraction = false;
                  widget.seekTo(_visibleValue);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInteraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  _visibleValue = Duration(milliseconds: newValue.floor());
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt.body(widget.currentPosition.durationToString),
                Txt.body(widget.duration.durationToString),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
