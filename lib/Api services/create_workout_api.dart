import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/create_workout_model.dart';
import 'package:http/http.dart';

class CreateWorkoutAPI {
  Future<List<CreateworkoutModel>> getCategoriesList(String lang) async {
    try {
      final response = await get(
        Uri.parse('$base_URL/workout_categorie/all'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization':
              'Bearer ${sharedPreferences.getString('access_token')}',
          'timeZone': getTimezone()
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<CreateworkoutModel> Exersises = [];

        List data = jsonDecode(response.body)['data'] ?? [];
        data.forEach((element) {
          Exersises.add(CreateworkoutModel.fromCategoriesJson(element));
        });
        print(Exersises);
        return Exersises;
      } else {
        print(jsonDecode(response.body));
        return [];
      }
    } catch (e) {
      print('Get Categories List Error: $e');
      return [];
    }
  }

  Future<List<CreateworkoutModel>> getExercisesList(String lang) async {
    try {
      final response = await get(
        Uri.parse('$base_URL/excersise/all'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization':
              'Bearer ${sharedPreferences.getString('access_token')}',
          'timeZone': getTimezone()
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<CreateworkoutModel> Exersises = [];

        List data = jsonDecode(response.body)['data'] ?? [];
        data.forEach((element) {
          Exersises.add(CreateworkoutModel.fromExercisesJson(element));
        });
        print(Exersises);
        return Exersises;
      } else {
        print(jsonDecode(response.body));
        return [];
      }
    } catch (e) {
      print('Get Exersises List Error: $e');
      return [];
    }
  }

  static Future<CreateworkoutModel?> CreateWorkout(
      CreateworkoutModel user, String lang) async {
    try {
      print(sharedPreferences.get('access_token'));
      final Response response =
          await post(Uri.parse('$base_URL/workout/create'),
              headers: <String, String>{
                // "Access-Control-Allow-Origin": "*",
                // 'Content-Type': 'application/json;charset=UTF-8'
                'Accept': 'application/json',
                'apikey': apiKey,
                'lang': lang,
                'authorization':
                    'Bearer ${sharedPreferences.getString('access_token')}',
                'timeZone': getTimezone()
              },
              body: user.toJson());
      print(user.toJson());
      print(response.body);
      if (response.statusCode.toString() == '201' ||
          response.statusCode.toString() == '200') {
        // responseString
        print('yeeeeeeess');
        return CreateworkoutModel.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        // print(response.body);
        return CreateworkoutModel.fromJsonWithErrors(
            json.decode(response.body));
        // CreateworkoutModel.fromJsonWithErrors(
        //     json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return CreateworkoutModel(
        message: 'There is a problem connecting to the internet',
        statusCode: 0);
  }
}
