// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/diet_model.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class DietAPI {
  Future<Map> createDiet(
      {required String name, required List meals, required String lang}) async {
    try {
      print(meals);
      final response =
          await http.post(Uri.parse('$base_URL/diet/create'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization':
            'Bearer ${sharedPreferences.getString('access_token')}',
        'timeZone': getTimezone()
      }, body: {
        'name': name,
        'meals': jsonEncode(meals)
      });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': jsonDecode(response.body)['message']
        };
      } else
        return {
          'success': false,
          'message': jsonDecode(response.body)['message']
        };
    } catch (e) {
      print('Create Diet Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map> updateDiet(
      {required int id, required List meals, required String lang}) async {
    try {
      print(meals);
      final response =
          await http.post(Uri.parse('$base_URL/diet/update'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization':
            'Bearer ${sharedPreferences.getString('access_token')}',
        'timeZone': getTimezone()
      }, body: {
        'diet_id': id.toString(),
        'meals': jsonEncode(meals)
      });
      print(jsonDecode(response.body));
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': jsonDecode(response.body)['message']
        };
      } else
        return {
          'success': false,
          'message': jsonDecode(response.body)['message']
        };
    } catch (e) {
      print('Update Diet Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map> deleteDiet({required int id, required String lang}) async {
    try {
      final response =
          await http.post(Uri.parse('$base_URL/diet/delete'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization':
            'Bearer ${sharedPreferences.getString('access_token')}',
        'timeZone': getTimezone()
      }, body: {
        'diet_id': id.toString(),
      });

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': jsonDecode(response.body)['message']
        };
      } else
        return {
          'success': false,
          'message': jsonDecode(response.body)['message']
        };
    } catch (e) {
      print('Delete Diet Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<List<DietModel>> getDietsList(
      {required String lang, required int page}) async {
    print('Called');
    try {
      final response = await http.get(
        Uri.parse('$base_URL/diet/all?page=$page'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization':
              'Bearer ${sharedPreferences.getString('access_token')}',
          'timeZone': getTimezone()
        },
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<DietModel> newDiet = [];
        final data = jsonDecode(response.body)['data'] as List;
        data.forEach((element) {
          newDiet.add(DietModel.fromJson(element));
        });
        return newDiet;
      } else {}
    } catch (e) {
      print('Get Foods List Error: $e');
    }
    return [];
  }

  Future<List<DietModel>> getSavedDiets(
      {required String lang, required int page}) async {
    print('Called');
    try {
      final response = await http.get(
        Uri.parse('$base_URL/diet/all?page=$page'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization':
              'Bearer ${sharedPreferences.getString('access_token')}',
          'timeZone': getTimezone()
        },
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<DietModel> newDiet = [];
        final data = jsonDecode(response.body)['data'] as List;
        data.forEach((element) {
          newDiet.add(DietModel.fromJson(element));
        });
        return newDiet;
      } else {}
    } catch (e) {
      print('Get Foods List Error: $e');
    }
    return [];
  }

  Future<List<DietModel>> getUserDiets(
      {required String lang, required int page}) async {
    print('Called');
    try {
      final response = await http.get(
        Uri.parse('$base_URL/diet/all?page=$page'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization':
              'Bearer ${sharedPreferences.getString('access_token')}',
          'timeZone': getTimezone()
        },
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<DietModel> newDiet = [];
        final data = jsonDecode(response.body)['data'] as List;
        data.forEach((element) {
          newDiet.add(DietModel.fromJson(element));
        });
        return newDiet;
      } else {}
    } catch (e) {
      print('Get Foods List Error: $e');
    }
    return [];
  }

  Future<List<DietModel>> getAnotherUserDiets(
      {required String lang, required int page}) async {
    print('Called');
    try {
      final response = await http.get(
        Uri.parse('$base_URL/diet/all?page=$page'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization':
              'Bearer ${sharedPreferences.getString('access_token')}',
          'timeZone': getTimezone()
        },
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<DietModel> newDiet = [];
        final data = jsonDecode(response.body)['data'] as List;
        data.forEach((element) {
          newDiet.add(DietModel.fromJson(element));
        });
        return newDiet;
      } else {}
    } catch (e) {
      print('Get Foods List Error: $e');
    }
    return [];
  }

  Future<DietModel> getSpeDiet({required String lang, required int id}) async {
    try {
      final response =
          await http.post(Uri.parse('$base_URL/diet/show'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization':
            'Bearer ${sharedPreferences.getString('access_token')}',
        'timeZone': getTimezone()
      }, body: {
        'diet_id': id.toString()
      });

      if (response.statusCode == 200) {
        return DietModel.fromJsonForFull(jsonDecode(response.body)['data']);
      }
    } catch (e) {
      print('Get Specific Diet Error: $e');
      return DietModel();
    }
    return DietModel();
  }
}
