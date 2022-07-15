import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/forget_password_api.dart';
import 'package:home_workout_app/models/forget_password_model.dart';

class ForgetPasswordViewModel with ChangeNotifier {
  bool obscureCode = true;

  changeCodeobscure() {
    obscureCode = !obscureCode;
    print(obscureCode);
    notifyListeners();
  }

  postEmail(String emailVal, String c_nameVal) async {
    ForgetPasswordModel? result;
    try {
      await ForgetPasswordAPI.createEmail(ForgetPasswordModel(
        email: emailVal,
        c_name: c_nameVal,
      )).then((value) {
        print(value);

        result = value;
      });
    } catch (e) {
      print(e);
    }

    return result;
  }

  String? checkCode(String code) {
    if (code.isEmpty) {
      return ' Please enter code';
    } else if (code.length < 5) {
      return ' Code should be 5 characters';
    } else {
      return null;
    }
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
}
