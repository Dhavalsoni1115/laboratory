import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/complete/presentation/screens/complete_screen.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/login/presentation/screens/login_screen.dart';
import 'package:laboratory/ongoing/presentation/screens/ongoing_screen.dart';
import 'package:laboratory/open/presentation/screens/open_screen.dart';
import 'package:laboratory/shared/data/data_source/get_staff_data.dart';
import 'package:laboratory/shared/presentation/model/staff_model.dart';
import 'package:laboratory/shared/services/notification_service.dart';
import 'package:laboratory/splash/presentation/screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login/data/data_source/staff_shared_pref.dart';

class HomeScreen extends StatefulWidget {
  final String staffId;
  const HomeScreen({Key? key, required this.staffId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int groupValue = 0;
  Future<String> getFcmToken() async {
    String fcmToken = await FirebaseMessaging.instance
        .getToken()
        .then((value) => value.toString());
    print(fcmToken);
    return fcmToken;
    // print(await FirebaseMessaging.instance.getToken());
  }

  @override
  void initState() {
    super.initState();
    print('=-=-=-=-=-=-=-');
    //getFcmToken();
    print('=-=-=-=-=-=-=-');
    //print(FirebaseMessaging.instance.getToken());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              backgroundColor: primaryColor,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text('Appointments'),
              ),
              titleTextStyle: TextStyle(fontSize: 18),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to Logout?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: secondaryColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                var loginPref = LoginSharedPrefrance();
                                await loginPref.removeToken();

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ));
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
              bottom: const TabBar(indicatorColor: secondaryColor, tabs: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Open'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Ongoing'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Completed'),
                ),
              ]),
            ),
          ),
          body: TabBarView(
            children: [
              OpenScreen(staffId: widget.staffId),
              OnGoingScreen(
                staffId: widget.staffId,
              ),
              CompleteScreen(
                staffId: widget.staffId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
