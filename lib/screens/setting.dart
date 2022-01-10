import 'package:deep_sleep/exporter.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late final user = FirebaseAuth.instance.currentUser!;
  String showName(String? name) {
    if (name != null && name.isNotEmpty) {
      return name;
    } else {
      return 'Anonymous';
    }
  }

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
                  child: Txt.title(showName(user.displayName)),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((_) {
                      HiveHelper.signOut();
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dashboard.pad)
                .copyWith(left: 8),
          ),
          ...List.generate(
            3,
            (i) => Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (i == 0) {
                      launch(
                        Uri(
                          scheme: 'mailto',
                          path: 'akhil.sharma@myrl.tech',
                        ).toString(),
                      );
                    } else if (i == 1) {
                      const DetailedView('Term of service', kTermOfService)
                          .push(context);
                    } else {
                      const DetailedView('Privacy policy', kPrivacyPolicy)
                          .push(context);
                    }
                  },
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

class DetailedView extends StatelessWidget {
  const DetailedView(this.title, this.item);
  final String title;
  final String item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dashboard.pad),
        child: SafeArea(
          child: Text(item),
        ),
      ),
    );
  }
}
