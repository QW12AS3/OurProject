import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/post_models.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class PostAPI {
  Future<Map> postPoll(
      {required int type,
      required String title,
      required List choices,
      required String lang}) async {
    try {
      print(title);
      final response =
          await http.post(Uri.parse('$base_URL/posts/poll'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization':
            'Bearer ${sharedPreferences.getString('access_token')}',
        'timeZone': getTimezone()
      }, body: {
        'type': type.toString(),
        'text': title,
        if (type == 3) 'votes': jsonEncode(choices)
      });
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return {
          'success': true,
          'message': jsonDecode(response.body)['message']
        };
      } else {
        print(jsonDecode(response.body));
        return {
          'success': false,
          'message': jsonDecode(response.body)['message']
        };
      }
    } catch (e) {
      print('Create Poll Post Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<List<PostModel>> getPosts(String lang) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/posts'),
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
        List<PostModel> posts = [];
        print(jsonDecode(response.body)['data']);
        List data = jsonDecode(response.body)['data'] ?? [];
        data.forEach((element) {
          posts.add(PostModel.fromJson(element));
        });
        return posts;
      } else {
        return [];
      }
    } catch (e) {
      print('Get Posts Error: $e');
      return [];
    }
  }
}
