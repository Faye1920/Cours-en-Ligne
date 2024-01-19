import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cours_en_ligne/screens/user_creation.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/splash.png'),
      nextScreen: EcranCreationUtilisateur(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 2000,
    );
  }
}
