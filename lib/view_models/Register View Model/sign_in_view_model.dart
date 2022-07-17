import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/sign_in_api.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/sign_in_model.dart';

class signInViewModel with ChangeNotifier {
  bool obscurePassword = true;
  var statusCode = 0;
  late BuildContext statusCodeContext;
  changePasswordobscure() {
    obscurePassword = !obscurePassword;
    print(obscurePassword);
    notifyListeners();
  }

  postUserInfo(String emailVal, String passwordVal, String m_tokenVal,
      String macVal, String c_nameVal) async {
    SignInModel? result;
    try {
      await SignInAPI.createUser(SignInModel(
        email: emailVal,
        password: passwordVal,
        c_name: c_nameVal,
        m_token: m_tokenVal,
        mac: macVal,
      )).then((value) {
        print(value);
        result = value;
      });
    } catch (e) {
      print("postUserInfo in signInViewModel error: $e");
    }

    if ((result!.access_token != null && result!.access_token != '') &&
        (result!.statusCode == 201)) {
      setData(result!);
    }
    return result;
  }

  setData(SignInModel Data) async {
    print(Data.access_token!);
    sharedPreferences.setString("access_token", Data.access_token!);
    sharedPreferences.setString("refresh_token", Data.refresh_token!);
    sharedPreferences.setString("token_expiration", Data.token_expiration!);
    sharedPreferences.setInt("role_id", Data.role_id!);
    sharedPreferences.setString("role_name", Data.role_name!);
    sharedPreferences.setBool("googleProvider", Data.googleProvider!);
    sharedPreferences.setBool("is_verified", Data.is_verified!);
    sharedPreferences.setBool("is_info", Data.is_info!);
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
}
