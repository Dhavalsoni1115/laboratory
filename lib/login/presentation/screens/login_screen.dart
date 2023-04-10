import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/login/presentation/widgets/login_button.dart';
import 'package:laboratory/login/presentation/widgets/textfield_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _loginKey = GlobalKey<FormState>();
    bool passwordVisible = true;
    IconData passwordIcon = Icons.remove_red_eye_rounded;
    String email, password;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
                  TextFormFieldData(
                    controoler: emailController,
                    obscureText: false,
                    labelText: 'Email *',
                    prefixIcon: Icons.email,
                    onSaved: (emailValue) {
                      setState(() {
                        email = emailValue.toString();
                        print(emailValue);
                        print(email);
                      });
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormFieldData(
                      obscureText: passwordVisible,
                      controoler: passwordController,
                      labelText: 'Password *',
                      prefixIcon: Icons.key,
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible == false
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: primaryColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            passwordVisible = !passwordVisible;
                            print(passwordVisible);
                          });
                        },
                      ),
                      onSaved: (passwordValue) {
                        setState(() {
                          password = passwordValue.toString();
                        });
                      },
                      validator: (String? value) {
                        return (value != null) ? 'Enter Password' : null;
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
                        onPress: () {
                          // print(email.toString());
                          // print(password.toString());
                          // Validate returns true if the form is valid, or false otherwise.
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
