import 'package:cached_network_image/cached_network_image.dart';
import 'package:deep_sleep/exporter.dart';
import 'package:page_transition/page_transition.dart';

extension OnWidget on Widget {
  Route<PageRoute> get route => PageTransition(
        type: PageTransitionType.rightToLeft,
        duration: kAnimationDuration,
        curve: accelerateEasing,
        reverseDuration: kAnimationDuration,
        child: this,
      );
  void push(BuildContext context, {bool useRootNav = false}) => Navigator.of(
        context,
        rootNavigator: useRootNav,
      ).push(route);
  List<Widget> operator *(int v) => List.generate(v, (i) => this);
}

extension OnNullableString on String? {
  Widget? get netImg => this == null
      ? null
      : CachedNetworkImage(
          imageUrl: this!,
          fit: BoxFit.cover,
          errorWidget: (c, _, __) => const SizedBox.shrink(),
          placeholder: (c, _) => const SizedBox.shrink(),
        );
}

extension OnString on String {
  String get capitalize => "${this[0].toUpperCase()}${substring(1)}";

  String get lowerCaseWithoutSpace => replaceAll(' ', '').toLowerCase();
}

extension OnDuration on Duration {
  String get durationToString {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final twoDigitHours = twoDigits(inHours);
    final twoDigitMinutes =
        twoDigits(inMinutes.remainder(Duration.minutesPerHour));
    final twoDigitSeconds =
        twoDigits(inSeconds.remainder(Duration.secondsPerMinute));
    return '${(int.tryParse(twoDigitHours) ?? 0) > 0 ? '$twoDigitHours:' : ''}$twoDigitMinutes:$twoDigitSeconds';
  }

  String get detailedTime {
    if (inHours > 0) {
      return '$inHours hr${inHours == 1 ? '' : 's'}';
    } else if (inMinutes > 0) {
      return '$inMinutes min${inMinutes == 1 ? '' : 's'}';
    } else {
      return '$inSeconds sec${inSeconds == 1 ? '' : 's'}';
    }
  }
}

extension OnJiffy on Jiffy {
  int get toIntDate => int.parse(Jiffy(this).format('yyyyMMdd'));
}

extension OnBox<T> on Box<T> {
  Map<String, T> get toTypeMap =>
      toMap().map<String, T>((k, v) => MapEntry(k.toString(), v));
}
