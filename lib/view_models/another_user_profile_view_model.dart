// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/profile_api.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/models/post_models.dart';
import 'package:home_workout_app/models/user_model.dart';

import '../Api services/post_api.dart';

class AnotherUserProfileViewModel with ChangeNotifier {
  UserModel _anotherUserData = UserModel();
  bool _isLoading = false;
  bool _infoWidgetVisible = false;

  List _followers = [];
  List _followings = [];

  bool _isPostLoading = false;

  List<PostModel> _userPosts = [];
  int _page = 0;

  bool _postsIsOpened = false;

  void setPostIsOpened(value) {
    _postsIsOpened = value;
    notifyListeners();
  }

  void setIsPostLoading(value) {
    _isPostLoading = value;
    notifyListeners();
  }

  void setPage(int i) {
    _page = i;
    notifyListeners();
  }

  Future<void> setAnotherUserPosts(String lang, int userId) async {
    print('getting');
    setPage(getPage + 1);
    setIsPostLoading(true);
    List<PostModel> newPosts =
        await PostAPI().getAnotherUserPosts(lang, getPage, userId);
    _userPosts.addAll(newPosts);
    if (newPosts.isEmpty) setPage(getPage - 1);
    setIsPostLoading(false);
    notifyListeners();
  }

  void clearPosts() {
    _userPosts.clear();
    notifyListeners();
  }

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

  Future<void> blockUser(int id, String lang, BuildContext context) async {
    bool response = await ProfileApi().blockUser(id, lang);
    if (response)
      _anotherUserData.isBlocked = true;
    else {
      showSnackbar(Text('Block failed'), context);
    }
    notifyListeners();
  }

  Future<void> unblockUser(int id, String lang, BuildContext context) async {
    bool response = await ProfileApi().unblockUser(id, lang);
    if (response)
      _anotherUserData.isBlocked = false;
    else {
      showSnackbar(Text('Unblock failed'), context);
    }
    notifyListeners();
  }

  Future<void> setFollowers(int id, String lang) async {
    _followers = await ProfileApi().getFollowers(lang, id);
    notifyListeners();
  }

  Future<void> setFollowings(int id, String lang) async {
    _followings = await ProfileApi().getFollowings(lang, id);
    notifyListeners();
  }

  Future<void> setFollow(int id, String lang, BuildContext context) async {
    _isLoading = true;
    final response = await ProfileApi().followUser(id, lang);

    if (response['success']) {
      _anotherUserData.followed = true;
      _anotherUserData.followers = response['followers'];
      _anotherUserData.followings = response['followings'];
      _isLoading = false;
    } else {
      showSnackbar(Text('Follow failed'), context);
    }

    notifyListeners();
  }

  Future<void> setUnfollow(int id, String lang, BuildContext context) async {
    _isLoading = true;
    final response = await ProfileApi().unFollowUser(id, lang);
    if (response['success']) {
      _anotherUserData.followed = false;
      _anotherUserData.followers = response['followers'];
      _anotherUserData.followings = response['followings'];
      _isLoading = false;
    } else {
      showSnackbar(Text('Unfollow failed'), context);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setUserData(int id, BuildContext context) async {
    _isLoading = true;
    _anotherUserData =
        await ProfileApi().getAnotherUserProfile('en', id, context);
    _isLoading = false;
    notifyListeners();
  }

  UserModel get getUserData => _anotherUserData;
  bool get getIsLoading => _isLoading;
  bool get getInfoWidgetVisible => _infoWidgetVisible;
  List get getFollowers => _followers;
  List get getFollowings => _followings;
  bool get getPostIsOpened => _postsIsOpened;
  bool get getIsPostLoading => _isPostLoading;

  int get getPage => _page;
  List<PostModel> get getUserPosts => _userPosts;
}
