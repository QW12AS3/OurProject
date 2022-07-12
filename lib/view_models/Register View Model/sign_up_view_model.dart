import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:home_workout_app/Api%20services/sign_up_api.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/sign_up_model.dart';
import 'package:http/http.dart';

class SignUpViewModel with ChangeNotifier {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  changePasswordobscure() {
    obscurePassword = !obscurePassword;
    // print(obscurePassword);
    notifyListeners();
  }

  changeConfirmPasswordobscure() {
    obscureConfirmPassword = !obscureConfirmPassword;
    // print(obscureConfirmPassword);
    notifyListeners();
  }

  postUserInfo(
      String f_nameVal,
      String l_nameVal,
      String emailVal,
      String passwordVal,
      String ConfirmPasswordVal,
      String m_tokenVal,
      String macVal,
      String c_nameVal) async {
    SignUpModel? result;
    try {
      await SignUpAPI.createUser(SignUpModel(
              f_name: f_nameVal,
              l_name: l_nameVal,
              email: emailVal,
              password: passwordVal,
              password_confirmation: ConfirmPasswordVal,
              m_token: m_tokenVal,
              mac: macVal,
              c_name: c_nameVal))
          .then((value) {
        print(value);

        result = value;
      });
    } catch (e) {
      print("postUserInfo in SignUpViewModel error: $e");
    }

    if ((result!.access_token != null && result!.access_token != '') &&
        (result!.statusCode == 201)) {
      setData(result!);
    }
    return result;
  }

  setData(SignUpModel Data) async {
    sharedPreferences.setString("access_token", Data.access_token!);
    sharedPreferences.setString("refresh_token", Data.refresh_token!);
    sharedPreferences.setString("token_expiration", Data.token_expiration!);
    sharedPreferences.setInt("role_id", Data.role_id!);
    sharedPreferences.setString("role_name", Data.role_name!);
    sharedPreferences.setBool("googleProvider", Data.googleProvider!);
  }

  String? checkFirstName(String name) {
    if (name.isEmpty) {
      return ' Please enter first name';
    } else
      return null;
  }

  String? checkLastName(String name) {
    if (name.isEmpty) {
      return ' Please enter last name';
    } else
      return null;
  }

  String? checkEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty) {
      return ' Please enter email';
    } else if (!emailValid) {
      return ' Invalid email';
    } else
      return null;
  }

  String? checkPassword(String password) {
    if (password.isEmpty) {
      return ' Please enter password';
    } else if (password.length < 6) {
      return ' Password should be at least 6 characters';
    } else {
      return null;
    }
  }

  String? checkConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return ' Please enter password';
    } else if (confirmPassword != password) {
      return " This password isn't the same as the previous password";
    } else if (password.length < 6) {
      return ' Password should be at least 6 characters';
    } else {
      return null;
    }
  }
}
