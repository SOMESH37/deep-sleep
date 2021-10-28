/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  Assets._();

  static const SvgGenImage facebook = SvgGenImage('asset/facebook.svg');
  static const SvgGenImage google = SvgGenImage('asset/google.svg');
  static const SvgGenImage navBarFour = SvgGenImage('asset/nav_bar_four.svg');
  static const SvgGenImage navBarOne = SvgGenImage('asset/nav_bar_one.svg');
  static const SvgGenImage navBarThree = SvgGenImage('asset/nav_bar_three.svg');
  static const SvgGenImage navBarTwo = SvgGenImage('asset/nav_bar_two.svg');
  static const AssetGenImage onboardOne =
      AssetGenImage('asset/onboard_one.png');
  static const AssetGenImage onboardThree =
      AssetGenImage('asset/onboard_three.png');
  static const AssetGenImage onboardTwo =
      AssetGenImage('asset/onboard_two.png');
  static const AssetGenImage scenery1 = AssetGenImage('asset/scenery1.png');
  static const AssetGenImage scenery10 = AssetGenImage('asset/scenery10.png');
  static const AssetGenImage scenery11 = AssetGenImage('asset/scenery11.png');
  static const AssetGenImage scenery12 = AssetGenImage('asset/scenery12.png');
  static const AssetGenImage scenery2 = AssetGenImage('asset/scenery2.png');
  static const AssetGenImage scenery3 = AssetGenImage('asset/scenery3.png');
  static const AssetGenImage scenery4 = AssetGenImage('asset/scenery4.png');
  static const AssetGenImage scenery5 = AssetGenImage('asset/scenery5.png');
  static const AssetGenImage scenery6 = AssetGenImage('asset/scenery6.png');
  static const AssetGenImage scenery7 = AssetGenImage('asset/scenery7.png');
  static const AssetGenImage scenery8 = AssetGenImage('asset/scenery8.png');
  static const AssetGenImage scenery9 = AssetGenImage('asset/scenery9.png');
  static const AssetGenImage splash = AssetGenImage('asset/splash.png');
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
