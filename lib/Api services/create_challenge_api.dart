import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/create_challenge_model.dart';
import 'package:http/http.dart';

class CreateChallengeAPI {
  static Future<CreateChallengeModel> createChallenge(
      CreateChallengeModel user, String lang) async {
    try {
      var request = MultipartRequest("Post", Uri.parse('$base_URL/ch'));
      request.headers['accept'] = 'application/json';
      request.headers['apikey'] = apiKey;
      request.headers['timeZone'] = getTimezone();
      request.headers['authorization'] =
          'Bearer ${sharedPreferences.getString('access_token')}';
      request.fields['name'] = 'user.name!';
      request.fields['end_time'] = '2022-8-8';
      request.fields['time'] = '1';
      request.fields['count'] = '100';
      request.fields['ex_id'] = '1';
      request.fields['desc'] = '1re';
      // request.fields['gender'] = gender.name;
      // request.fields['birthdate'] = birthdate.toString();
      // request.fields['country'] = country;
      // request.fields['_method'] = 'PUT';
      print(sharedPreferences.get('access_token'));
      if (user.img?.path != '') {
        var pic = await MultipartFile.fromPath("img", user.img!.path);
        request.files.add(pic);
      }
      // final Response response = await post(Uri.parse('$base_URL/ch'),
      //     headers: <String, String>{
      //       // "Access-Control-Allow-Origin": "*",
      //       // 'Content-Type': 'application/json;charset=UTF-8'
      //       'Accept': 'application/json',
      //       'apikey': apiKey,
      //       'lang': lang,
      //       'timeZone': getTimezone()
      //     },
      //     body: user.toJson());

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      // print(Response.fromStream(response));
      print(responseString);
      print(response.statusCode);
      final respStr = await response.stream.bytesToString();
      print(respStr);
      if (response.statusCode == 200) {
        return CreateChallengeModel(
            message: 'There is a problem connecting to the internet',
            statusCode: 0);
        // CreateChallengeModel.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        // print(response.body);
        return CreateChallengeModel(
            message: 'There is a problem connecting to the internet',
            statusCode: 0);
        // CreateChallengeModel.fromJsonWithErrors(
        //     json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return CreateChallengeModel(
        message: 'There is a problem connecting to the internet',
        statusCode: 0);
  }

  Future<List<CreateChallengeModel>> getChallengesList(String lang) async {
    try {
      final response = await get(
        Uri.parse('$base_URL/ch/list'),
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
        List<CreateChallengeModel> challenges = [];

        List data = jsonDecode(response.body)['data'] ?? [];
        data.forEach((element) {
          challenges.add(CreateChallengeModel.fromChallengesJson(element));
        });
        print(challenges);
        return challenges;
      } else {
        print(jsonDecode(response.body));
        return [];
      }
    } catch (e) {
      print('Get challenges List Error: $e');
      return [];
    }
  }
}
