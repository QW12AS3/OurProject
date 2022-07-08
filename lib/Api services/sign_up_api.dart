import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_up_model.dart';
import 'package:http/http.dart' as http;

class SignUpAPI {
  static Future<SignUpModel> createUser(SignUpModel user) async {
    try {
      final http.Response response = await http.post(Uri.parse('$base_URL/'),
          headers: <String, String>{
            // 'Content-Type': 'application/json;charset=UTF-8'
            'Accept': 'application/json',
            'apikey': apiKey,
            'lang': 'en',
            'timeZone': 'Asia/Damascus'
          },
          body: user.toJson());

      print(response.statusCode);
      if (response.statusCode == 201) {
        print('respoooooooooooooooooooooooooooooooonse');
        print(response.body);
        return SignUpModel.fromJson(json.decode(response.body));
      } else {
        print((response.statusCode.toInt() / 100).toInt());
        print('dddddddddddddddddddddddddddddddddddd');
        print(response.statusCode);
        print(response.body);
        return SignUpModel.fromJsonWithErrors(json.decode(response.body));
        // print(response.m)
        // throw "can't do sign up";
        // return SignUpModel(email: '', password: '', token: '',message:'');
      }
    } catch (e) {
      print(e);
    }
    return SignUpModel(message: '');
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
        Uri.parse('$base_URL/user/info'),
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

  Future<List> getDiseases(String lang) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/diseases'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization': token,
          'timeZone': getTimezone()
        },
      );
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'] ?? [];
        print(data);
        return data;
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Get diseases error: $e');

      return [];
    }
    return [];
  }
}
