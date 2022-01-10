import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  Assets._();
  static const sceneries = [
    scenery1,
    scenery2,
    scenery3,
    scenery4,
    scenery5,
    scenery6,
    scenery7,
    scenery8,
    scenery9,
    scenery10,
    scenery11,
    scenery12,
    scenery13,
    scenery14,
    scenery15,
    scenery16,
    scenery17,
    scenery18,
    scenery19,
    scenery20,
    scenery21,
    scenery22,
  ];
  static const AssetGenImage beach = AssetGenImage('asset/beach.jpg');
  static const AssetGenImage breeze = AssetGenImage('asset/breeze.jpg');
  static const AssetGenImage camping = AssetGenImage('asset/camping.jpg');
  static const AssetGenImage drizzle = AssetGenImage('asset/drizzle.jpg');
  static const SvgGenImage facebook = SvgGenImage('asset/facebook.svg');
  static const AssetGenImage flute = AssetGenImage('asset/flute.jpg');
  static const SvgGenImage google = SvgGenImage('asset/google.svg');
  static const AssetGenImage guitar = AssetGenImage('asset/guitar.jpg');
  static const AssetGenImage harp = AssetGenImage('asset/harp.jpg');
  static const AssetGenImage kalimba = AssetGenImage('asset/kalimba.jpg');
  static const AssetGenImage musicBox = AssetGenImage('asset/music_box.jpg');
  static const SvgGenImage navBarFour = SvgGenImage('asset/nav_bar_four.svg');
  static const SvgGenImage navBarOne = SvgGenImage('asset/nav_bar_one.svg');
  static const SvgGenImage navBarThree = SvgGenImage('asset/nav_bar_three.svg');
  static const SvgGenImage navBarTwo = SvgGenImage('asset/nav_bar_two.svg');
  static const AssetGenImage piano = AssetGenImage('asset/piano.jpg');
  static const AssetGenImage scenery1 = AssetGenImage('asset/scenery1.png');
  static const AssetGenImage scenery10 = AssetGenImage('asset/scenery10.png');
  static const AssetGenImage scenery11 = AssetGenImage('asset/scenery11.png');
  static const AssetGenImage scenery12 = AssetGenImage('asset/scenery12.png');
  static const AssetGenImage scenery13 = AssetGenImage('asset/scenery13.png');
  static const AssetGenImage scenery14 = AssetGenImage('asset/scenery14.png');
  static const AssetGenImage scenery15 = AssetGenImage('asset/scenery15.png');
  static const AssetGenImage scenery16 = AssetGenImage('asset/scenery16.png');
  static const AssetGenImage scenery17 = AssetGenImage('asset/scenery17.png');
  static const AssetGenImage scenery18 = AssetGenImage('asset/scenery18.png');
  static const AssetGenImage scenery19 = AssetGenImage('asset/scenery19.png');
  static const AssetGenImage scenery2 = AssetGenImage('asset/scenery2.png');
  static const AssetGenImage scenery20 = AssetGenImage('asset/scenery20.png');
  static const AssetGenImage scenery21 = AssetGenImage('asset/scenery21.png');
  static const AssetGenImage scenery22 = AssetGenImage('asset/scenery22.png');
  static const AssetGenImage scenery3 = AssetGenImage('asset/scenery3.png');
  static const AssetGenImage scenery4 = AssetGenImage('asset/scenery4.png');
  static const AssetGenImage scenery5 = AssetGenImage('asset/scenery5.png');
  static const AssetGenImage scenery6 = AssetGenImage('asset/scenery6.png');
  static const AssetGenImage scenery7 = AssetGenImage('asset/scenery7.png');
  static const AssetGenImage scenery8 = AssetGenImage('asset/scenery8.png');
  static const AssetGenImage scenery9 = AssetGenImage('asset/scenery9.png');
  static const AssetGenImage seaWave = AssetGenImage('asset/sea_wave.jpg');
  static const AssetGenImage splash = AssetGenImage('asset/splash.png');
  static const AssetGenImage swamp = AssetGenImage('asset/swamp.jpg');
  static const AssetGenImage ukelele = AssetGenImage('asset/ukelele.jpg');
  static const AssetGenImage waterfall = AssetGenImage('asset/waterfall.jpg');
  static const AssetGenImage windChimes =
      AssetGenImage('asset/wind_chimes.jpg');
  static const AssetGenImage woodFire = AssetGenImage('asset/wood_fire.jpg');
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
