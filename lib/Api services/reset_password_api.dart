import 'dart:convert';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/Reset_password_model.dart';
import 'package:http/http.dart';

class ResetPasswordAPI {
  static Future<ResetPasswordModel> createUser(ResetPasswordModel user) async {
    try {
      final Response response = await post(Uri.parse('$base_URL'),
          headers: <String, String>{
            //  "Access-Control-Allow-Origin": "*",
            // 'Content-Type': 'application/json;charset=UTF-8'
            'Accept': 'application/json',
            'apikey': apiKey,
            'lang': 'en',
            'timeZone': getTimezone(),
          },
          body: user.toJson());
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        return ResetPasswordModel.fromJson(json.decode(response.body));
      } else {
        print(response.body);
        return ResetPasswordModel.fromJsonWithErrors(
            json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return ResetPasswordModel(
        message: 'There is a problem connecting to the internet',
        statusCode: 0);
  }
}
