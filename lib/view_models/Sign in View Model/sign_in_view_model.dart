import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class signInViewModel with ChangeNotifier {
  bool obscurePassword = true;

  changePasswordobscure() {
    obscurePassword = !obscurePassword;
    print(obscurePassword);
    notifyListeners();
  }
}

class api {
  static const String _BASE_URL = 'https://reqres.in/api';
  static Future<Response> createUser(String email, String password) async {
    final Response response = await post(Uri.parse('$_BASE_URL/login'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body:
            jsonEncode(<String, String>{"email": email, "password": password}));
    if (response.statusCode / 100 == 2) {
      print(response.body);
    } else {
      print(response.body);
      //  throw Exception("create user api error");
    }
    // notifyListeners();
    return response;
  }
}
