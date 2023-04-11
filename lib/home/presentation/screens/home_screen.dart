import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/open/presentation/screens/open_screen.dart';
import 'package:laboratory/splash/presentation/screen/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int groupValue = 0;
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
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              backgroundColor: primaryColor,
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
                              onPressed: () => Navigator.pop(context, 'OK'),
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
              bottom: TabBar(indicatorColor: secondaryColor, tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Open'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Ongoing'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Completed'),
                ),
              ]),
            ),
          ),
          body: const TabBarView(
            children: [
              OpenScreen(),
              SplashScreen(),
              SplashScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
