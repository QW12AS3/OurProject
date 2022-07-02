import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:home_workout_app/Api%20services/sign_in_api.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if (result?.error == null) setData(result!);
    return result;
  }

  setData(SignInModel Data) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("f_name", Data.f_name!);
    _pref.setString("l_name", Data.l_name!);
    _pref.setString("email", Data.email!);
    _pref.setString("profile_img", Data.profile_img!);
    _pref.setString("access_token", Data.access_token!);
    _pref.setString("refresh_token", Data.refresh_token!);
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
