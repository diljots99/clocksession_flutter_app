import 'package:flutter/material.dart';
import 'package:flutter_app/api/ApiService.dart';
import 'package:flutter_app/models/LoginModel.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/pages/dashboard/dasboard.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool remember_me = false;

  void _togglePasswordView() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            height: 500,
            child: Card(
              child: Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x002e74),
                      ),
                      child: Image(
                        image: AssetImage('lib/assets/images/clocklogol.png'),
                      ),
                    ),
                    Text(
                      'Login',
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: email_controller,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Enter a valid email!';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: 'Enter Email',
                                label: Text(
                                  'Email ',
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: password_controller,
                              obscureText: _isObscure,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  icon: Icon(Icons.password),
                                  suffixIcon: IconButton(
                                      onPressed: _togglePasswordView,
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        value: this.remember_me,
                                        onChanged: (value) {
                                          setState(() {
                                            this.remember_me = value ?? false;
                                          });
                                        }),
                                    Text('Remember Me')
                                  ],
                                ),
                                Text('Forgot Password?')
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //       content: Text('Logging in......')),
                                  // );

                                  print("Login Pressed");
                                  print('email: ${email_controller.text}');
                                  print(
                                      'password: ${password_controller.text}');
                                  ApiService obj = ApiService();
                                  LoginRequest body = LoginRequest(
                                      email: email_controller.text,
                                      password: password_controller.text);
                                  try {
                                    dynamic user = await obj.login(body);
                                    if (user is User) {
                                      print(user.id);
                                      print(user.email);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DashboardPage()),
                                      );
                                    } else {
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                            message: user['message']),
                                      );
                                    }
                                  } catch (error) {
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                        message:
                                            "Something went wrong. Please try again later",
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
