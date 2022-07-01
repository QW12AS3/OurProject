import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:home_workout_app/view_models/Sign%20in%20View%20Model/sign_in_view_model.dart';
import 'package:http/http.dart';

class SignInAPI {
  static Future<SignInModel> createUser(SignInModel user) async {
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
      return SignInModel.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      print(response.body);
      return SignInModel.fromJsonWithErrors(json.decode(response.body));
      // print(response.m)
      // throw "can't do sign in";
      // return SignInModel(email: '', password: '', token: '',error:'');
    }
  }
}
