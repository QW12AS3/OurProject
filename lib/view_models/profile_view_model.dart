// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/profile_api.dart';
import 'package:home_workout_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel with ChangeNotifier {
  UserModel _userData = UserModel();
  bool _isLoading = false;

  bool _infoWidgetVisible = false;
  List _followers = [];
  List _followings = [];

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

  Future<void> setCurrentUserData() async {
    _isLoading = true;
    _userData = await ProfileApi().getUserProfile('en');
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await ProfileApi().logout('en');
  }

  Future<void> logoutFromAll() async {
    await ProfileApi().logoutFromAll('en');
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

  UserModel get getUserData => _userData;
  bool get getInfoWidgetVisible => _infoWidgetVisible;
  bool get getIsLoading => _isLoading;
  List get getFollowers => _followers;
  List get getFollowings => _followings;
  //bool get getPasswordObsecure => _PasswordObsecure;
}
