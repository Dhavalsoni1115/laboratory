import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/home/presentation/screens/home_screen.dart';
import 'package:laboratory/login/presentation/screens/login_screen.dart';
import 'package:laboratory/splash/presentation/screen/splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      //     AnimatedSplashScreen(
      //   backgroundColor: backgroundColor,
      //   splash: SplashScreen(),
      //   nextScreen: LoginScreen(),
      //   duration: 1000,
      //   splashTransition: SplashTransition.fadeTransition,
      // ),
    );
  }
}
