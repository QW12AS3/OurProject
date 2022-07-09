import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:home_workout_app/Api%20services/sign_in_api.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signInViewModel with ChangeNotifier {
  bool obscurePassword = true;
  var statusCode = 0;
  late BuildContext statusCodeContext;
  changePasswordobscure() {
    obscurePassword = !obscurePassword;
    print(obscurePassword);
    notifyListeners();
  }

  postUserInfo(String emailVal, String passwordVal, String c_nameVal) async {
    SignInModel? result;
    try {
      await SignInAPI.createUser(SignInModel(
        email: emailVal,
        password: passwordVal,

        c_name: c_nameVal,
        m_token: '',
        mac: '',
        // message: '',
      )).then((value) {
        print(value);
        // print("toooooooooooooken:   " + value.access_token!);
        // print("messaaaaaaaaaaaaaage:${value.}")

        result = value;
      });
    } catch (e) {
      print(e);
    }
    setStatusCode(var statusCodeValue) {
      statusCode = statusCodeValue;
      notifyListeners();
      print("staaaaaaaaaaaaaaaaattttttuuuuuuuuus" + "$statusCode");
    }

    setStatusCodeContext(BuildContext statusCodeContextValue) {
      statusCodeContext = statusCodeContextValue;
      notifyListeners();
      print(
          "staaaaaaaaaaaaaaaaattttttuuuuuuuuusContext " + "$statusCodeContext");
    }

    if (result!.access_token != null && result!.refresh_token != null)
      setData(result!);
    return result;
  }

  setData(SignInModel Data) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    // _pref.setString("f_name", Data.f_name!);
    // _pref.setString("l_name", Data.l_name!);
    // _pref.setString("email", Data.email!);
    // _pref.setString("profile_img", Data.profile_img!);
    _pref.setString("access_token", Data.access_token!);
    _pref.setString("refresh_token", Data.refresh_token!);
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
    // RegExp regex = RegExp(
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[/?,.!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return ' Please enter password';
    } else if (password.length < 6) {
      return ' Password should be at least 6 characters';
    } else {
      return null;
    }
  }
}
