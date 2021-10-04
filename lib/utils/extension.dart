import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';
import '/exporter.dart';

extension OnWidget on Widget {
  Route<PageRoute> get route => PageTransition(
        type: PageTransitionType.rightToLeft,
        duration: kAnimationDuration,
        curve: accelerateEasing,
        reverseDuration: kAnimationDuration,
        child: this,
      );
  void push(BuildContext context) => Navigator.of(context).push(route);
  List<Widget> operator *(int v) => List.generate(v, (i) => this);
}

extension OnString on String? {
  Widget? get netImg => this == null
      ? null
      : CachedNetworkImage(
          imageUrl: this!,
          errorWidget: (c, _, __) => const SizedBox.shrink(),
          placeholder: (c, _) => const SizedBox.shrink(),
        );
}
