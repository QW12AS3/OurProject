import 'package:flutter/widgets.dart';
import 'package:home_workout_app/Api%20services/otp_api.dart';
import 'package:home_workout_app/models/otp_model.dart';

class otpViewModel with ChangeNotifier {
  bool obscureCode = true;

  changeCodeobscure() {
    obscureCode = !obscureCode;
    print(obscureCode);
    notifyListeners();
  }

  postUserInfo(String emailVal, String passwordVal, String c_nameVal) async {
    OTPModel? result;
    try {
      await OTPAPI
          .createUser(OTPModel(
        email: emailVal,
        password: passwordVal,

        c_name: c_nameVal,
        m_token: '',
        mac: '',
        // message: '',
      ))
          .then((value) {
        print(value);
        // print("toooooooooooooken:   " + value.access_token!);
        // print("messaaaaaaaaaaaaaage:${value.}")

        result = value;
      });
    } catch (e) {
      print(e);
    }

    // if (result!.access_token != null && result!.refresh_token != null)
    //   setData(result!);
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
}
