import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../shared/data/data_source/get_staff_data.dart';
import '../../../shared/presentation/model/staff_model.dart';
import '../../data/data_source/staff_shared_pref.dart';
import '../widgets/common_textfield.dart';
import '../widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  IconData passwordIcon = Icons.remove_red_eye_rounded;
  String? email, password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<StaffModel> staffData = [];

  getStaff() async {
    var staff = Staff();
    List<dynamic> staffDynamicData = await staff.getStaffDetail();
    staffData =
        staffDynamicData.map((data) => StaffModel.fromJson(data)).toList();
    setState(() {
      staffData;
    });
    print(staffData);
    return staffData;
  }

  void getPermission() async {
    _requestPerms();
  }

  void _requestPerms() async {
    await [Permission.locationWhenInUse, Permission.locationAlways].request();

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      openAppSettings();
    }
  }

  StaffModel? selectedStaffData;
  getSelectedStaff(String staffId) async {
    var staff = Staff();
    dynamic staffData = await staff.getSelectStaffDetail(staffId);
    selectedStaffData = StaffModel.fromJson(staffData);
    setState(() {
      selectedStaffData;
    });
    print(selectedStaffData);
    return selectedStaffData;
  }

  @override
  void initState() {
    super.initState();
    getStaff();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = true;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: _loginKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    child: CommonTextField(
                      labelName: 'Email',
                      obscureText: false,
                      onChange: (emailValue) {
                        email = emailValue;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                      child: CommonTextField(
                        labelName: 'Password',
                        obscureText: true,
                        onChange: (passwordValue) {
                          password = passwordValue;
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onDoubleTap: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TextFormField(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: LoginButton(
                        buttonColor: primaryColor,
                        onPress: () async {
                          if (_loginKey.currentState!.validate()) {
                          } else {}
                          var loginUser = Staff();
                          var staffId = await loginUser.signInStaff(
                            context: context,
                            email: email!,
                            password: password!,
                          );
                          if (staffId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Incorrect Email And Password.'),
                              ),
                            );
                          }
                          await getSelectedStaff(staffId);
                          String selectedId =
                              await selectedStaffData!.id.toString();

                          if (staffId == selectedStaffData!.id) {
                            if (selectedStaffData!.active == true) {
                              if (isLoading == true) {
                                Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: backgroundColor,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              getPermission();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login Sucessfull'),
                                ),
                              );

                              var sharedPref = LoginSharedPrefrance();
                              await sharedPref
                                  .storeLoginToken(staffId.toString());
                              Center(
                                child: LoadingAnimationWidget.dotsTriangle(
                                  color: secondaryColor,
                                  size: 200,
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    staffId: staffId.toString(),
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please Contact Admin'),
                                ),
                              );
                            }
                          }

                          // print(selectedStaffdata.toJson());
                        },
                        buttonName: 'Login',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
