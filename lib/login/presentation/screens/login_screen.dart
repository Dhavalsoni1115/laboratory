import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/home/presentation/screens/home_screen.dart';
import 'package:laboratory/login/presentation/widgets/login_button.dart';
import 'package:laboratory/login/presentation/widgets/textfield_data.dart';
import 'package:laboratory/shared/data/data_source/get_staff_data.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../shared/presentation/model/staff_model.dart';
import '../../data/data_source/staff_shared_pref.dart';
import '../widgets/common_textfield.dart';

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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                    //  TextFormField(
                    //   controller: emailController,
                    //   obscureText: false,
                    //   decoration: InputDecoration(
                    //     // hintText: 'Email',
                    //     border: InputBorder.none,
                    //     label: Text('Email'),
                    //   ),
                    //   onChanged: (emailValue) {
                    //     setState(() {
                    //       email = emailValue.toString();
                    //       print(emailValue);
                    //       print(email);
                    //     });
                    //   },
                    //   validator: (String? value) {
                    //     return (value == null) ? 'Enter Email' : null;
                    //   },
                    // ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
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
                          print(email);
                          print(password);
                          var loginUser = Staff();
                          //getCuttentStaffId();
                          print('********');

                          var staffId = await loginUser.signInStaff(
                            context: context,
                            email: email!,
                            password: password!,
                          );
                          print(staffId);
                          if (_loginKey.currentState!.validate() && staffId != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Sucessfull')),
                            );
                          }else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Incorrect Email And Password.')),
                            ); 
                          }

                          //await sharedPref.storeLoginToken(staffId.toString());
                          // String token = await sharedPref.getLoginToken();
                          // print(token);
                          print('xcvbxchvbxhmcv======');
                          await getSelectedStaff(staffId);
                          String selectedId =
                              await selectedStaffData!.id.toString();

                          if (staffId == selectedStaffData!.id) {
                            if (selectedStaffData!.active == true) {
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
