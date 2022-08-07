import 'package:flutter/material.dart';
import 'package:flutter_app/api/ApiService.dart';
import 'package:flutter_app/models/LoginModel.dart';
import 'package:flutter_app/models/User.dart';
import 'package:http/http.dart';

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
  int _counter = 0;
  String _email = "";
  String _paswword = "";
  bool _remember_me = false;
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _email_change() {
    setState(() {
      _email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login Page',
            ),
            TextField(
              controller: email_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Email',
                label: Text(
                  'Email ',
                ),
              ),
            ),
            TextField(
              controller: password_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Password',
                label: Text(
                  'Password',
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                print("Login Pressed");
                print('email: ${email_controller.text}');
                print('password: ${password_controller.text}');
                ApiService obj = ApiService();
                LoginRequest body = LoginRequest(
                    email: email_controller.text,
                    password: password_controller.text);

                Future<User> response = obj.login(body);
                response.then((value) => {print(value.token)});
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
