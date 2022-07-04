import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_up_model.dart';
import 'package:http/http.dart' as http;

class SignUpAPI {
  static Future<SignUpModel> createUser(SignUpModel user) async {

   

    // try {
     final response = await http.post(Uri.parse('$base_URL/login'),

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

  Future sendUserInfo(
      Gender gender,
      DateTime birthdate,
      String height,
      String weight,
      String country,
      String heightUnit,
      String weightUnit) async {
    try {
      print(height);
      final response = await http.post(
        Uri.parse(url + '/user/info'),
        headers: {
          'apikey': apiKey,
          'lang': 'en',
          'accept': 'application/json',
          'authorization': token
        },
        body: {
          'height': height,
          'height_unit': heightUnit,
          'weight': weight,
          'weight_unit': weightUnit,
          'gender': gender.name,
          'birth_date': birthdate.toString(),
          'country': country
        },
      );

      if (response.statusCode == 200) {
        print('success');
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Sending info error: $e');
    }
  }
}
