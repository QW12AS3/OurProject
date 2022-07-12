import 'dart:convert';

import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/otp_model.dart';
import 'package:http/http.dart';

class OTPAPI {
  static Future<OTPModel> createUser(OTPModel user, String addedURL) async {
    try {
      String? access_Token = sharedPreferences.getString('access_token');
      print('aceeeeeeeeeeeeeess_token:   $access_Token');
      final Response response = await post(Uri.parse('$base_URL$addedURL'),
          headers: <String, String>{
            // 'Content-Type': 'application/json;charset=UTF-8'
            'Accept': 'application/json',
            'apikey': apiKey,
            'lang': 'en',
            'timeZone': getTimezone(),
            'authorization': 'Bearer $access_Token'
          },
          body: user.toJson());
      print(response.body);
      if (response.statusCode == 201) {
        print(response.body);
        return OTPModel.fromJson(json.decode(response.body));
      } else {
        print(response.body);
        return OTPModel.fromJsonWithErrors(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return OTPModel(message: '', statusCode: 0);
  }
}
