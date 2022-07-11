import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_in_view_model.dart';
import 'package:http/http.dart';

class SignInAPI {
  static Future<SignInModel> createUser(SignInModel user) async {
    try {
      final Response response = await post(Uri.parse('$base_URL/login'),
          headers: <String, String>{
            // "Access-Control-Allow-Origin": "*",
            // 'Content-Type': 'application/json;charset=UTF-8'
            'Accept': 'application/json',
            'apikey': apiKey,
            'lang': 'en',
            'timeZone': 'Asia/Damascus'
          },
          body: user.toJson());

      print(response.body);
      if (response.statusCode == 201) {
        return SignInModel.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        print(response.body);
        return SignInModel.fromJsonWithErrors(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return SignInModel(message: '', statusCode: 0);
  }
}
