import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/auth/login/login_screen.dart';
import 'package:sera/ui/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    final user = SharedPreferenceHelper.instance().isUserLoggedIn;
    const loginRoute = LoginScreen.route;
    const mainRoute = MainScreen.route;
    if (user == true) {
      Future.delayed(const Duration(seconds: 5)).then((_) {
        Navigator.pushNamedAndRemoveUntil(context, mainRoute, (_) => false);
      });
    } else {
    Future.delayed(const Duration(seconds: 5)).then((_) {
      Navigator.pushNamedAndRemoveUntil(context, loginRoute, (_) => false);
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    final size = context.mediaSize;
    return Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            Container(
                width: size.width,
                height: size.height,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/3x/Splash Screen.png'),
                        fit: BoxFit.fill))),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
