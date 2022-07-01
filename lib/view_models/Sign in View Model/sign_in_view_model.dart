import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:home_workout_app/Api%20services/sign_in_api.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:http/http.dart';

class signInViewModel with ChangeNotifier {
  bool obscurePassword = true;

  changePasswordobscure() {
    obscurePassword = !obscurePassword;
    print(obscurePassword);
    notifyListeners();
  }

  postUserInfo(String emailVal, String passwordVal) async {
    SignInModel? result;
    await SignInAPI.createUser(SignInModel(
      email: // "eve.holt@reqres.in" "d3Dfhghfgh#"
          emailVal,
      password: passwordVal,
      // "cityslicka",
      // token: '',
      // error: '',
    )).then((value) {
      print(value);
      print("dddddddddassdads" + value.access_token!);

      result = value;
    });
    return result;
  }

  String? checkEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid)
      return ' Invalid email';
    else
      return null;
  }

  String? checkPassword(String password) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[/?,.!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(password)) {
        return ' Invalid password';
      } else {
        return null;
      }
    }
  }
}
