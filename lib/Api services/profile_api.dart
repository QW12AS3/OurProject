// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:home_workout_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class ProfileApi {
  Future<UserModel> getUserProfile(String lang) async {
    try {
      final response =
          await http.get(Uri.parse('$base_URL/user/profile'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization': token
      });

      if (response.statusCode == 200) {
        UserModel _userModel = UserModel.fromJson(jsonDecode(response.body));
        print(_userModel);
        return _userModel;
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Get profile error: $e');
    }
    return UserModel();
  }

  Future<UserModel> getAnotherUserProfile(String lang, int id) async {
    try {
      final response =
          await http.get(Uri.parse('$base_URL/user/profile/$id'), headers: {
        'apikey': apiKey,
        'lang': lang,
        'accept': 'application/json',
        'authorization': token
      });

      if (response.statusCode == 200) {
        UserModel _userModel = UserModel.fromJson(jsonDecode(response.body));
        print(_userModel);
        return _userModel;
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Get another profile error: $e');
    }
    return UserModel();
  }

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
          http.MultipartRequest("Post", Uri.parse('$base_URL/user/update'));
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
        Uri.parse('$base_URL/user/updateEmail'),
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
        Uri.parse('$base_URL/user/updatePassword'),
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

  Future<void> logout(String lang) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/user/logout'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
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

  Future<void> logoutFromAll(String lang) async {
    //
    try {
      final response = await http.get(
        Uri.parse('$base_URL/user/all_logout'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
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

  Future<Map<String, dynamic>> followUser(int id, String lang) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/user/follow/$id'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization': token
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return {
          'success': true,
          'followers': data['data']['followers'],
          'followings': data['data']['followings'],
        };
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Follow error: $e');
      return {'success': false};
    }
    return {'success': false};
  }

  Future<Map<String, dynamic>> unFollowUser(int id, String lang) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/user/unfollow/$id'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization': token
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return {
          'success': true,
          'followers': data['data']['followers'],
          'followings': data['data']['followings'],
        };
      } else {
        print(jsonDecode(response.body));
        return {'success': false};
      }
    } catch (e) {
      print('Unfollow error: $e');
      return {'success': false};
    }
  }

  Future<List> getFollowers(String lang, int id) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/user/followers/$id'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization': token
        },
      );
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'] ?? [];
        print(data);
        return data;
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Get followers error: $e');

      return [];
    }
    return [];
  }

  Future<List> getFollowings(String lang, int id) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/user/following/$id'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization': token
        },
      );
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'] ?? [];
        print(data);
        return data;
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print('Get followings error: $e');

      return [];
    }
    return [];
  }

  Future<bool> blockUser(int id, String lang) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/user/block/$id'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization': token
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return true;
      } else {
        print(jsonDecode(response.body));
        return false;
      }
    } catch (e) {
      print('Block error: $e');
      return false;
    }
  }

  Future<bool> unblockUser(int id, String lang) async {
    try {
      final response = await http.get(
        Uri.parse('$base_URL/user/unblock/$id'),
        headers: {
          'apikey': apiKey,
          'lang': lang,
          'accept': 'application/json',
          'authorization': token
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return true;
      } else {
        print(jsonDecode(response.body));
        return false;
      }
    } catch (e) {
      print('Block error: $e');
      return false;
    }
  }
}
