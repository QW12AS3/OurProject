import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:http/http.dart';

class SignInAPI {
  static Future<SignInModel> createUser(SignInModel user) async {
    final Response response = await post(Uri.parse('$base_URL/login'),
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
      // return SignInModel(email: '', password: '', token: '',message:'');
    }
  }
}
