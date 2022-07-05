import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/profile_api.dart';
import 'package:home_workout_app/models/user_model.dart';

class AnotherUserProfileViewModel with ChangeNotifier {
  UserModel _anotherUserData = UserModel();
  bool _isLoading = false;
  bool _infoWidgetVisible = false;

  List _followers = [];
  List _followings = [];

  setInfoWidgetVisible(bool value) {
    _infoWidgetVisible = value;
    notifyListeners();
  }

  Map<dynamic, dynamic> user = {
    'id': 2,
    'data': {
      'fname': 'Omar',
      'lname': 'Za',
      'gender': 'male',
      'followed': false,
      'country': 'Syria',
      'birthdate': '2001-6-21',
      'imageUrl':
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg',
      'role': 'Coach',
      'role_id': 2,
      'finishedWorkouts': 5,
      'enteredWorkouts': 7,
      'bio':
          'Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test '
    }
  };

  Future<void> blockUser(int id, String lang) async {
    bool response = await ProfileApi().blockUser(id, lang);
    if (response) _anotherUserData.isBlocked = true;
    notifyListeners();
  }

  Future<void> unblockUser(int id, String lang) async {
    bool response = await ProfileApi().unblockUser(id, lang);
    if (response) _anotherUserData.isBlocked = false;
    notifyListeners();
  }

  Future<void> setFollowers(int id, String lang) async {
    _followers = await ProfileApi().getFollowers(lang, id);
    notifyListeners();
  }

  Future<void> setFollowings(int id, String lang) async {
    _followers = await ProfileApi().getFollowings(lang, id);
    notifyListeners();
  }

  Future<void> setFollow(int id, String lang) async {
    _isLoading = true;
    final response = await ProfileApi().followUser(id, lang);

    if (response['success']) {
      _anotherUserData.followed = true;
      _anotherUserData.followers = response['followers'];
      _anotherUserData.followings = response['followings'];
      _isLoading = false;
    }

    notifyListeners();
  }

  Future<void> setUnfollow(int id, String lang) async {
    _isLoading = true;
    final response = await ProfileApi().unFollowUser(id, lang);
    if (response['success']) {
      _anotherUserData.followed = false;
      _anotherUserData.followers = response['followers'];
      _anotherUserData.followings = response['followings'];
      _isLoading = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setUserData(int id) async {
    _isLoading = true;
    _anotherUserData = await ProfileApi().getAnotherUserProfile('en', id);
    _isLoading = false;
    notifyListeners();
  }

  UserModel get getUserData => _anotherUserData;
  bool get getIsLoading => _isLoading;
  bool get getInfoWidgetVisible => _infoWidgetVisible;
  List get getFollowers => _followers;
  List get getFollowings => _followings;
}
