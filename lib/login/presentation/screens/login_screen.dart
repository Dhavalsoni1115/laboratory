import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/home/presentation/screens/home_screen.dart';
import 'package:laboratory/login/presentation/widgets/login_button.dart';
import 'package:laboratory/login/presentation/widgets/textfield_data.dart';
import 'package:laboratory/shared/data/data_source/get_staff_data.dart';

import '../../../shared/presentation/model/staff_model.dart';

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
                  TextFormField(
                    controller: emailController,
                    //controoler: emailController,
                    obscureText: false,
                    onChanged: (emailValue) {
                      setState(() {
                        email = emailValue.toString();
                        print(emailValue);
                        print(email);
                      });
                    },
                    // labelText: 'Email *',
                    // prefixIcon: Icons.email,
                    // onSaved: (emailValue) {
                    //   setState(() {
                    //     email = emailValue.toString();
                    //     print(emailValue);
                    //     print(email);
                    //   });
                    // },
                    validator: (String? value) {
                      // return (value != null && value.contains('@'))
                      //     ? 'Do not use the @ char.'
                      //     : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      obscureText: passwordVisible,
                      controller: passwordController,
                      //labelText: 'Password *',
                      // prefixIcon: Icons.key,
                      // suffixIcon: IconButton(
                      //   icon: Icon(
                      //     // Based on passwordVisible state choose the icon
                      //     passwordVisible == false
                      //         ? Icons.visibility
                      //         : Icons.visibility_off,
                      //     color: primaryColor,
                      //   ),
                      //   onPressed: () {
                      //     // Update the state i.e. toogle the state of passwordVisible variable
                      //     setState(() {
                      //       passwordVisible = !passwordVisible;
                      //       print(passwordVisible);
                      //     });
                      //   },
                      // ),
                      onChanged: (passwordValue) {
                        setState(() {
                          password = passwordValue.toString();
                        });
                      },
                      validator: (String? value) {
                        // return (value != null) ? 'Enter Password' : null;
                      },
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
                          if (_loginKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please Enter Email and Password.'),
                              ),
                            );
                          }

                          var loginUser = Staff();
                          //getCuttentStaffId();
                          print('********');

                          var staffId = await loginUser.signInStaff(
                            context: context,
                            email: email!,
                            password: password!,
                          );
                          print(staffId);
                          // StaffModel selectedStaffdata =
                          //     await loginUser.getSelectStaffDetail(staffId);
                          // getSelectedStaffDetail(staffId);

                          print('xcvbxchvbxhmcv======');
                          await getSelectedStaff(staffId);
                          String selectedId =
                              await selectedStaffData!.id.toString();
                          if (staffId == selectedStaffData!.id) {
                            if (selectedStaffData!.active == true) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
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
