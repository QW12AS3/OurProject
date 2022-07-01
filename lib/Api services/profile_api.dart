// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class ProfileApi {
  editProfile(
    String fname,
    String lname,
    XFile image,
    String bio,
    double height,
    double weight,
    Gender gender,
    DateTime birthdate,
    String country,
  ) async {
    const String url = '';
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.headers[''] = ''; // !!!!!

      request.fields['fname'] = fname;
      request.fields['lname'] = lname;
      request.fields['bio'] = bio;
      request.fields['height'] = height.toString();
      request.fields['weight'] = weight.toString();
      request.fields['gender'] = gender == Gender.male ? 'male' : 'female';
      request.fields['birthdate'] = birthdate.toString();
      request.fields['country'] = country;

      if (image.path != '') {
        var pic = await http.MultipartFile.fromPath("image", image.path);
        request.files.add(pic);
      }
      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
    } catch (e) {}
  }

  Future<bool> changeEmail(
      String oldEmail, String newEmail, String password) async {
    const String url = '';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {},
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
        return false;
      }
    } catch (e) {
      print('Change Email Error: $e');
    }
    return false;
  }

  Future<bool> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    const String url = '';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {},
        body: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmNewPassword
        },
      );
      if (response.statusCode == 200) {
        print('Change Password success');
        return true;
      } else {
        print('Change Password failed');
        return false;
      }
    } catch (e) {
      print('Change Password Error: $e');
    }
    return false;
  }
}
