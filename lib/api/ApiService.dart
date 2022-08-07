import 'package:flutter_app/models/LoginModel.dart';
import 'package:flutter_app/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _base_url = "";

  Future<dynamic> login(LoginRequest body) async {
    final response = await http.post(
        Uri.parse('http://devl-api.clocksession.com/api/Account/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-API-VERSION': '1.0.0'
        },
        body: jsonEncode(<String, dynamic>{
          'email': body.email,
          'password': body.password,
        }));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic object = jsonDecode(response.body);
      return User.fromJson(object["data"]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      dynamic errorBody = jsonDecode(response.body);
      return errorBody;
    }
  }
}
