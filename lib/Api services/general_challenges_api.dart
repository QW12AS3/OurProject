import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/challenge_model.dart';
import 'package:http/http.dart';

class GeneralChallengesAPI {
  Future<List<ChallengeModel>> getUserchallenges(String lang, int page) async {
    try {
      print('Page $page');
      final response = await get(
        Uri.parse('$base_URL/ch?page=$page'),
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
        List<ChallengeModel> challenges = [];

        List data = jsonDecode(response.body)['data'] ?? [];
        data.forEach((element) {
          challenges.add(ChallengeModel.fromJson(element));
        });
        print(challenges);
        return challenges;
      } else {
        print(jsonDecode(response.body));
        return [];
      }
    } catch (e) {
      print('Get challenges Error: $e');
      return [];
    }
  }
}
