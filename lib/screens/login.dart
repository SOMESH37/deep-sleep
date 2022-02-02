import 'package:deep_sleep/exporter.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int loading = -1;

  void setLoading(int i) => mounted ? setState(() => loading = i) : null;

  Future<void> googleLogin(BuildContext context) async {
    final sign = GoogleSignIn(scopes: ['email', 'profile']);
    final user = await sign.signIn();
    if (user == null) return;
    final auth = await user.authentication;
    await FirebaseAuth.instance
        .signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: auth.accessToken,
            idToken: auth.idToken,
          ),
        )
        .then(popAndPullData);
    await sign.disconnect();
  }

  Future<void> fbLogin(BuildContext context) async {
    final result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      await FirebaseAuth.instance
          .signInWithCredential(
            FacebookAuthProvider.credential(result.accessToken!.token),
          )
          .then(popAndPullData);
    }
  }

  void popAndPullData([_]) {
    HiveHelper.pullFireStore();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screen.height,
      width: Screen.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.splash.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colours.scaffold.withOpacity(0.5),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Continue with',
                style: TextStyle(fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Row(
                  children: List.generate(
                    3,
                    (i) => i == 1
                        ? const SizedBox(width: 16)
                        : Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (loading != -1) return;
                                if (i == 0) {
                                  setLoading(0);
                                  fbLogin(context).then((_) => setLoading(-1));
                                  setLoading(-1);
                                } else {
                                  setLoading(1);
                                  googleLogin(context)
                                      .then((_) => setLoading(-1));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(120, 56),
                                primary:
                                    i == 0 ? Colours.facebook : Colors.white,
                              ),
                              child: loading == 0 && i == 0
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : loading == 1 && i == 2
                                      ? const CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (i == 0)
                                              Assets.facebook.svg(height: 32)
                                            else
                                              Assets.google.svg(height: 32),
                                            const SizedBox(width: 8),
                                            if (i == 0)
                                              const Text('Facebook')
                                            else
                                              const Text(
                                                'Google',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                          ],
                                        ),
                            ),
                          ),
                  ),
                ),
              ),
              const Text(
                'or',
                style: TextStyle(color: Colors.white70),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                child: ElevatedButton(
                  onPressed: () {
                    if (loading != -1) return;
                    setLoading(2);
                    FirebaseAuth.instance
                        .signInAnonymously()
                        .then(popAndPullData);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 56),
                    primary: Colours.elevationButton.withOpacity(0.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (loading == 2)
                        const CircularProgressIndicator(color: Colors.white70)
                      else
                        const Text(
                          'Continue anonymously',
                          style: TextStyle(color: Colors.white70),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: (Screen.height * 0.4 - 254).clamp(0, double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
