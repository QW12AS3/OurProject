import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_by_google_model.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_by_google_view_model.dart';
import 'package:http/http.dart';

class SignByGoogleAPI {
  static Future<SignByGoogleModel> createUser(SignByGoogleModel user) async {
    try {
      final Response response =
          await post(Uri.parse('$base_URL/login/callback'),
              headers: <String, String>{
                // 'Content-Type': 'application/json;charset=UTF-8'
                'Accept': 'application/json',
                'apikey':
                    'THSzx8cmJny4DFmjvjX2calOKSduaJxb3YKC9sCuoCdEiF4J9w6qul5kRFwt1mUR',
                'lang': 'en',
                'timeZone': 'Asia/Damascus'
              },
              body: user.toJson());
      print('ssssssssssssssssssssssssssssssssssssssssssssss');
      print(user.toJson());
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.body);
        return SignByGoogleModel.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        print(response.body);
        return SignByGoogleModel.fromJsonWithErrors(json.decode(response.body));
        // print(response.m)
        // throw "can't do sign in";
        // return SignByGoogleModel(email: '', password: '', token: '',message:'');
      }
    } catch (e) {
      print(e);
    }
    return SignByGoogleModel(message: '');
  }
}