import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/home/presentation/screens/home_screen.dart';
import 'package:laboratory/login/presentation/screens/login_screen.dart';
import 'package:laboratory/shared/presentation/screens/appoitment_detail_screen.dart';
import 'package:laboratory/open/presentation/screens/open_screen.dart';
import 'package:laboratory/shared/presentation/screens/map_show.dart';
import 'package:laboratory/splash/presentation/screen/splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/data/data_source/staff_shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var token;
  getToken() async {
    var sharedPref = LoginSharedPrefrance();
    token = await sharedPref.getLoginToken();
    //print(token);
    setState(() {
      token;
    });
    return token;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null
          ? AnimatedSplashScreen(
              backgroundColor: backgroundColor,
              splash: const SplashScreen(),
              nextScreen: const LoginScreen(),
              duration: 1000,
              splashTransition: SplashTransition.fadeTransition,
            )
          : HomeScreen(staffId: token.toString()),
    );
  }
}
