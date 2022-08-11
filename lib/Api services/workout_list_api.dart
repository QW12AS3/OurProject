import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/workout_list_model.dart';
import 'package:http/http.dart';

class WorkoutListsAPI {
  Future<List<WorkoutListModel>> getworkouts(String lang, String category,
      String difficulty, int page, String link) async {
    try {
      print('Page $page');
      print('$base_URL$link$category$difficulty?page=$page');
      final response = await get(
        Uri.parse('$base_URL$link$category$difficulty?page=$page'),
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
      print('Get workout list Error: $e');
      return [];
    }
  }

  Future<List<WorkoutListModel>> getUserworkouts(
      String lang, int uderId, int page) async {
    try {
      print('Page $page');
      // print('$base_URL$link$category$difficulty?page=$page');
      final response = await get(
        Uri.parse('$base_URL/workout/user/$uderId?page=$page'),
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
      print('Get USer workout list Error: $e');
      return [];
    }
  }

  Future<List<WorkoutListModel>> getCategoriesList(String lang) async {
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
        List<WorkoutListModel> Exersises = [];

        List data = jsonDecode(response.body)['data'] ?? [];
        data.forEach((element) {
          Exersises.add(WorkoutListModel.fromCategoriesJson(element));
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

  Future<WorkoutListModel> deleteWorkout(String lang, int? id) async {
    //business logic to send data to server
    try {
      final Response response = await delete(
        Uri.parse('$base_URL/workout/delete/$id'),
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
        return WorkoutListModel.fromJsonWithErrors(json.decode(response.body));
      } else {
        print(response.statusCode);
        print(response.body);
        return WorkoutListModel.fromJsonWithErrors(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return WorkoutListModel(
        message: 'There is a problem connecting to the internet',
        statusCode: 0);
  }

  Future<WorkoutListModel?> changeFavoriteState(String lang, int id) async {
    try {
      print(sharedPreferences.get('access_token'));
      final Response response = await post(
        Uri.parse('$base_URL/workout/favorite/$id'),
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
        // body: user.toJson()
      );
      // print(user.toJson());
      print(response.body);
      if (response.statusCode.toString() == '201' ||
          response.statusCode.toString() == '200') {
        // responseString
        print('yeeeeeeess');
        return WorkoutListModel.fromJsonWithErrors(json.decode(response.body));
      } else {
        print(response.statusCode);
        // print(response.body);
        return WorkoutListModel.fromJsonWithErrors(json.decode(response.body));
        // WorkoutListModel.fromJsonWithErrors(
        //     json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return WorkoutListModel(
        message: 'There is a problem connecting to the internet',
        statusCode: 0);
  }
}
