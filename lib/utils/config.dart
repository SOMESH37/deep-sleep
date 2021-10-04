import '/exporter.dart';

const kIsDeveloping = true;
const kAnimationDuration = Duration(milliseconds: 260);
const kAnimationCurve = decelerateEasing;

class Screen {
  Screen._();
  static void init(BuildContext c) => _data = MediaQuery.of(c);
  static late MediaQueryData _data;
  static Size get size => _data.size;
  static double get height => _data.size.height;
  static double get width => _data.size.width;
  static double get keyboardSize => _data.viewInsets.bottom;
  static double get topSafeAreaPadding => _data.padding.top;
  static double get verticalSafeAreaPadding =>
      _data.padding.top + _data.padding.bottom;
  static double get textScaleFactor => _data.textScaleFactor;
}
