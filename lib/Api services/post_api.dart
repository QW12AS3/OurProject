import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/comments_model.dart';
import 'package:home_workout_app/models/post_models.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../main.dart';

class PostAPI {
  Future<Map> postNormalPost(
      {required String title,
      required List<XFile> images,
      required List<XFile> videos}) async {
    try {
      var request = http.MultipartRequest("Post", Uri.parse('$base_URL/posts'));
      request.headers['accept'] = 'application/json';
      request.headers['apikey'] = apiKey;
      request.headers['timeZone'] = getTimezone();
      request.headers['authorization'] =
          'Bearer ${sharedPreferences.getString('access_token')}';

      request.fields['text'] = title;

      List<http.MultipartFile> media = [];
      // media.addAll(videos);
      // media.addAll(images);

      for (int i = 0; i < images.length; i++) {
        var pic =
            await http.MultipartFile.fromPath('media[$i]', images[i].path);
        print(i);
        media.add(pic);
      }
      for (int i = 0; i < videos.length; i++) {
        var pic = await http.MultipartFile.fromPath(
            'media[${i + images.length}]', videos[i].path);
        print(i);

        media.add(pic);
      }

      request.files.addAll(media);
      request.files.forEach((element) {
        print('field: ' + element.field);
      });

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      if (response.statusCode == 200) {
        return {'success': true, 'message': responseString};
      } else {
        return {'success': false, 'message': responseString};
      }
      return {};
    } catch (e) {
      print('Create Normal Post error: $e');

      return {'success': false, 'message': e.toString()};
    }
  }

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
