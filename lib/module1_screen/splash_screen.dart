import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../router.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'login_screen.dart';

class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('assets/cooknotes2.png'),
        nextScreen: LoginScreen(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        splashIconSize: 250,
        backgroundColor: Colors.white);
  }
}
