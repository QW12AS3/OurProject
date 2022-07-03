import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_up_model.dart';
import 'package:http/http.dart';

class SignUpAPI {
  static Future<SignUpModel> createUser(SignUpModel user) async {
    // try {
    final Response response = await post(Uri.parse('$base_URL/login'),
        headers: <String, String>{
          // 'Content-Type': 'application/json;charset=UTF-8'
          'Accept': 'application/json',
          'lang': 'en',
          'timeZone': 'Asia/Damascus'
        },
        body: jsonEncode(user.toJson()));
    print(response.statusCode);
    if (response.statusCode / 100 == 2) {
      print(response.body);
      return SignUpModel.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      print(response.body);
      return SignUpModel.fromJsonWithErrors(json.decode(response.body));
      // print(response.m)
      // throw "can't do sign up";
      // return SignUpModel(email: '', password: '', token: '',error:'');
    }
    // } catch (e) {
    //   return e;
    // }
  }
}
