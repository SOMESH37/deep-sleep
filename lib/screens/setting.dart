import 'package:cached_network_image/cached_network_image.dart';

import '/exporter.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final user = FirebaseAuth.instance.currentUser!;
  bool _isNoti = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dashboard.pad),
        children: [
          Container(
            padding: const EdgeInsets.all(Dashboard.pad).copyWith(left: 0),
            height: 88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colours.tabUnselected,
            ),
            child: Row(
              children: [
                Container(
                  height: 88,
                  width: 88,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Assets.splash.path),
                    ),
                  ),
                  child: user.photoURL.netImg,
                ),
                Expanded(
                  child: Txt.title(user.displayName ?? 'Anonymous'),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .signOut()
                        .then((_) => Navigator.pop(context));
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dashboard.pad)
                .copyWith(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable Notifications'),
                CupertinoSwitch(
                  value: _isNoti,
                  trackColor: Colours.tabUnselected,
                  activeColor: Colours.elevationButton,
                  onChanged: (_) => setState(() => _isNoti = !_isNoti),
                )
              ],
            ),
          ),
          ...List.generate(
            3,
            (i) => Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    i == 0
                        ? 'Contact us'
                        : i == 1
                            ? 'Term of service'
                            : 'Privacy policy',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
