// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class ProfileApi {
  Future<void> editProfile(
    String fname,
    String lname,
    XFile image,
    String bio,
    String height,
    String weight,
    Gender gender,
    DateTime birthdate,
    String country,
  ) async {
    try {
      var request =
          http.MultipartRequest("Post", Uri.parse('$url/user/update'));
      request.headers['accept'] = 'application/json';
      request.headers['apikey'] = apiKey;
      request.headers['authorization'] = token;
      request.fields['fname'] = fname;
      request.fields['lname'] = lname;
      request.fields['bio'] = bio;
      request.fields['height'] = height.toString();
      request.fields['weight'] = weight.toString();
      request.fields['gender'] = gender.name;
      request.fields['birthdate'] = birthdate.toString();
      request.fields['country'] = country;
      request.fields['_method'] = 'PUT';

      if (image.path != '') {
        var pic = await http.MultipartFile.fromPath("img", image.path);
        request.files.add(pic);
      }
      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
    } catch (e) {
      print('Update profile error: $e');
    }
  }

  Future<bool> changeEmail(
      String oldEmail, String newEmail, String password) async {
    //const String url = '';
    try {
      final response = await http.post(
        Uri.parse('$url/user/updateEmail'),
        headers: {
          'apikey': apiKey,
          'lang': 'en',
          'accept': 'application/json',
          'authorization': token
        },
        body: {
          'oldEmail': oldEmail,
          'newEmail': newEmail,
          'password': password
        },
      );
      if (response.statusCode == 200) {
        print('Change email success');
        return true;
      } else {
        print('Change email failed');
        print(jsonDecode(response.body));
        return false;
      }
    } catch (e) {
      print('Change Email Error: $e');
    }
    return false;
  }

  Future<bool> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$url/user/updatePassword'),
        headers: {
          'apikey': apiKey,
          'lang': 'en',
          'accept': 'application/json',
          'authorization': token
        },
        body: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'newPassword_confirmation': confirmNewPassword
        },
      );
      if (response.statusCode == 200) {
        print('Change Password success');
        return true;
      } else {
        print('Change Password failed');
        print(jsonDecode(response.body));

        return false;
      }
    } catch (e) {
      print('Change Password Error: $e');
    }
    return false;
  }

  Future<void> logout() async {
    try {
      final response = await http.get(
        Uri.parse('$url/user/logout'),
        headers: {
          'apikey': apiKey,
          'lang': 'ar',
          'accept': 'application/json',
          'authorization': token
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Logout Error: $e');
    }
  }

  Future<void> logoutFromAll() async {
    //
    try {
      final response = await http.get(
        Uri.parse('$url/user/all_logout'),
        headers: {
          'apikey': apiKey,
          'lang': 'ar',
          'accept': 'application/json',
          'authorization': token
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Logout Error: $e');
    }
  }
}
