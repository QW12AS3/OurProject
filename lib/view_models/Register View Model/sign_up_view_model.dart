import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:home_workout_app/Api%20services/sign_in_api.dart';
import 'package:home_workout_app/Api%20services/sign_up_api.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:home_workout_app/models/sign_up_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print("dddddddddassdads" + value.access_token!);

      result = value;
    });
    if (result?.error == null) setData(result!);
    return result;
  }

  setData(SignUpModel Data) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("f_name", Data.f_name!);
    _pref.setString("l_name", Data.l_name!);
    _pref.setString("email", Data.email!);
    _pref.setString("profile_img", Data.profile_img!);
    _pref.setString("access_token", Data.access_token!);
    _pref.setString("refresh_token", Data.refresh_token!);
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
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[/?,.!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return ' Please enter password';
    } else if (!regex.hasMatch(password)) {
      return ' Invalid password';
    } else {
      return null;
    }
  }

  String? checkConfirmPassword(String confirmPassword, String password) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[/?,.!@#\$&*~]).{8,}$');
    if (confirmPassword.isEmpty) {
      return ' Please enter password';
    } else if (confirmPassword != password)
      return " This password isn't the same as the previous password";
    else if (!regex.hasMatch(confirmPassword)) {
      return ' Invalid password';
    } else {
      return null;
    }
  }
}
