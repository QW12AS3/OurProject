import 'dart:convert';

import 'package:home_workout_app/models/meal_model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../main.dart';

class MealAPI {
  Future<Map> createMeal(
      {required String type,
      required String desc,
      required List<int> foodsIDs,
      required String lang}) async {
    try {
      print(foodsIDs);
      final response =
          await http.post(Uri.parse('$base_URL/meal/create'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization':
            'Bearer ${sharedPreferences.getString('access_token')}',
        'timeZone': getTimezone()
      }, body: {
        'type': type,
        'description': desc,
        'food_ids': jsonEncode(foodsIDs)
      });
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': jsonDecode(response.body)['message'] ?? '',
        };
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'] ?? '',
        };
      }
    } catch (e) {
      print('Create Meal Error: $e');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<List<MealModel>> getMealsList(
      {required String lang, required int page}) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/meal/all?page=$page'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization':
              'Bearer ${sharedPreferences.getString('access_token')}',
          'timeZone': getTimezone()
        },
      );
      if (response.statusCode == 200) {
        List<MealModel> newMeals = [];
        final data = jsonDecode(response.body) as List;
        data.forEach((element) {
          newMeals.add(MealModel.fromJson(element));
        });
        return newMeals;
      } else {}
    } catch (e) {
      print('Get Meals List Error: $e');
    }
    return [];
  }

  Future<Map> deleteMeal({required String lang, required int mealId}) async {
    try {
      final response =
          await http.post(Uri.parse('$base_URL/meal/delete'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization':
            'Bearer ${sharedPreferences.getString('access_token')}',
        'timeZone': getTimezone()
      }, body: {
        'food_id': mealId.toString()
      });
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': jsonDecode(response.body)['message'] ?? '',
        };
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'] ?? '',
        };
      }
    } catch (e) {
      print('Delete Meal Error: $e');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
