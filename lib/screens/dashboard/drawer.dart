import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/dashboard/data.dart';

class AppDrawer extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colours.scaffold,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Screen.width * 0.07,
                    horizontal: 8,
                  ),
                  child: CloseButton(
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height: 120,
                    width: 120,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(Assets.splash.path),
                      ),
                    ),
                    child: user.photoURL?.netImg,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Text(
                    'Hey ${(user.displayName?.split(' ').first) ?? 'there'}!',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ...List.generate(
                  DrawerData.items.length,
                  (i) {
                    final item = DrawerData.items[i];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (item.screen != null) {
                          item.screen!.push(context);
                        }
                      },
                      leading: Icon(
                        item.icon,
                        color: Colors.white70,
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
