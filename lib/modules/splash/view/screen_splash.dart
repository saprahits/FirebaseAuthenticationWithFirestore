import 'package:demo/utils/app_routes.dart';
import 'package:demo/utils/navigator_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///  * This Class use for Splash Screen,
///  * [Scaffold], which provides standard app elements like an [AppBar] and a [Drawer].
///  * [FirebaseAuth], which is used to manage the Firebase Auth user.
///  * [Navigator], which is used to manage the app's stack of pages.
class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    _auth.userChanges().listen(
      (currentUser) {
        if (currentUser != null) {
          setState(() => user = currentUser);
          NavigatorKey.navigatorKey.currentState!
              .pushNamedAndRemoveUntil(AppRoutes.routesHome, (route) => false);
        } else {
          NavigatorKey.navigatorKey.currentState!
              .pushNamedAndRemoveUntil(AppRoutes.routesLogin, (route) => false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}
