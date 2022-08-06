import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/create_workout_model.dart';
import 'package:http/http.dart';

class CreateWorkoutAPI {
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
          Exersises.add(CreateworkoutModel.fromexercisesJson(element));
        });
        print(Exersises);
        return Exersises;
      } else {
        print(jsonDecode(response.body));
        return [];
      }
    } catch (e) {
      print('Get exercises List Error: $e');
      return [];
    }
  }
}
