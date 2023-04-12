import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/home/presentation/screens/home_screen.dart';
import 'package:laboratory/login/presentation/screens/login_screen.dart';
import 'package:laboratory/open/presentation/screens/open_detail_screen.dart';
import 'package:laboratory/open/presentation/screens/open_screen.dart';
import 'package:laboratory/shared/presentation/screens/map_show.dart';
import 'package:laboratory/splash/presentation/screen/splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: primaryColor, // Note RED here
      ),
    );
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen()
        // OpenDetailScreen(),
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
