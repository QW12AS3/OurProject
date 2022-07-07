import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/otp_model.dart';
import 'package:http/http.dart';

class OTPAPI {
  static Future<OTPModel> createUser(OTPModel user) async {
    try {
      final Response response = await post(Uri.parse('$base_URL/'),
          headers: <String, String>{
            // 'Content-Type': 'application/json;charset=UTF-8'
            'Accept': 'application/json',
            'apikey':
                'THSzx8cmJny4DFmjvjX2calOKSduaJxb3YKC9sCuoCdEiF4J9w6qul5kRFwt1mUR',
            'lang': 'en',
            'timeZone': 'Asia/Damascus'
          },
          body: user.toJson());
      print('URRRRRRRRRRRRRRRRRRRRRRRRRLLLLLLLLLLLLLLLLLLLLLLL');
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.body);
        return OTPModel.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        print(response.body);
        return OTPModel.fromJsonWithErrors(json.decode(response.body));
        // print(response.m)
        // throw "can't do sign in";
        // return SignInModel(email: '', password: '', token: '',message:'');
      }
    } catch (e) {
      print(e);
    }
    return OTPModel(message: '');
  }
}
