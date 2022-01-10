import 'package:deep_sleep/exporter.dart';

class Stopper with ChangeNotifier {
  int _secLeft;
  late final VoidCallback fun;
  Stopper(this._secLeft, this.fun) {
    _main.tick;
  }

  @override
  void dispose() {
    _main.cancel();
    super.dispose();
  }

  bool _isActive = true;
  bool get isActive => _isActive;

  late final _main = Timer.periodic(const Duration(seconds: 1), (_) {
    if (_isActive) _secLeft--;
    if (_secLeft.isNegative) _secLeft = 0;
    notifyListeners();
    if (_secLeft == 0) {
      fun();
      dispose();
    }
  });

  void continueOrPause() => _isActive ? pause() : play();
  void pause() => _isActive = false;
  void play() => _isActive = true;

  Duration get remainingTime => Duration(seconds: _secLeft);

  /// Greater than 3 else ignored
  void updateTime(int? seconds) =>
      seconds != null && seconds > 3 ? _secLeft = seconds : null;
}
