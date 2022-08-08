import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/workout_list_model.dart';
import 'package:http/http.dart';

class WorkoutListsAPI {
  Future<List<WorkoutListModel>> getworkouts(
      String lang, int? page, String link) async {
    try {
      print('Page $page');
      final response = await get(
        Uri.parse('$base_URL$link'),
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
        List<WorkoutListModel> workouts = [];

        List data = jsonDecode(response.body)['data'] ?? [];
        data.forEach((element) {
          workouts.add(WorkoutListModel.fromJson(element));
        });
        print(workouts);
        return workouts;
      } else {
        print(jsonDecode(response.body));
        return [];
      }
    } catch (e) {
      print('Get worout list Error: $e');
      return [];
    }
  }
}
