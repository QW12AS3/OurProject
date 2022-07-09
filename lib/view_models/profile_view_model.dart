// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/profile_api.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/models/user_model.dart';
import 'package:home_workout_app/views/start_view/start_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel with ChangeNotifier {
  UserModel _userData = UserModel();
  bool _isLoading = false;

  bool _infoWidgetVisible = false;
  List _followers = [];
  List _followings = [];
  List _blocklist = [];

  //bool _PasswordObsecure = false;

  // void setPasswordObsecure() {
  //   _PasswordObsecure = !_PasswordObsecure;
  //   notifyListeners();
  // }

  Future<void> setFollowers(int id, String lang) async {
    _followers = await ProfileApi().getFollowers(lang, id);
    notifyListeners();
  }

  Future<void> setFollowings(int id, String lang) async {
    _followers = await ProfileApi().getFollowings(lang, id);
    notifyListeners();
  }

  setInfoWidgetVisible(bool value) {
    _infoWidgetVisible = value;
    notifyListeners();
  }

  // Map<dynamic, dynamic> user = {
  //   'id': 1,
  //   'data': {
  //     'fname': 'Omar',
  //     'lname': 'Za',
  //     'gender': 'male',
  //     'email': 'test@gmail.com',
  //     'country': 'Syria',
  //     'birthdate': '2001-6-21',
  //     'imageUrl':
  //         'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg',
  //     'role': 'Coach',
  //     'role_id': 2,
  //     'finishedWorkouts': 5,
  //     'enteredWorkouts': 7,
  //     'bio':
  //         'Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test '
  //   }
  // };

  Future<void> setCurrentUserData(BuildContext context) async {
    _isLoading = true;
    _userData = await ProfileApi().getUserProfile('en', context);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    final response = await ProfileApi().logout('en');
    if (response) {
      Navigator.pushNamed(context, 'startView');
    } else {
      showSnackbar(const Text('Logout failed'), context);
      Navigator.pop(context);
    }
  }

  Future<void> logoutFromAll(BuildContext context) async {
    final response = await ProfileApi().logoutFromAll('en');
    if (response) {
      Navigator.pushReplacementNamed(context, 'startView');
    } else {
      showSnackbar(const Text('Logout failed'), context);
      Navigator.pop(context);
    }
  }

  // Future<void> followUser() async {
  //   await ProfileApi().followUser(1, 'en');
  // }

  // Future<void> getFollowers() async {
  //   await ProfileApi().getFollowers('en');
  // }

  // Future<void> getFollowings() async {
  //   await ProfileApi().getFollowings('en');
  // }

  Future<void> deleteAccount(
      String password, String lang, BuildContext context) async {
    final response = await ProfileApi().deleteAccount(password, lang);
    if (response['success']) {
      Navigator.pushReplacementNamed(context, 'startView');
    } else {
      showSnackbar(Text(response['message'].toString()).tr(), context);
      Navigator.pop(context);
    }
  }

  Future<void> setBlocklist(String lang) async {
    _blocklist = await ProfileApi().getBlocklist(lang);
    notifyListeners();
  }

  UserModel get getUserData => _userData;
  bool get getInfoWidgetVisible => _infoWidgetVisible;
  bool get getIsLoading => _isLoading;
  List get getFollowers => _followers;
  List get getFollowings => _followings;
  List get getBlocklist => _blocklist;
  //bool get getPasswordObsecure => _PasswordObsecure;
}
