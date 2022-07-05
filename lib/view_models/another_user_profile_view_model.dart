import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/models/user_model.dart';

class AnotherUserProfileViewModel with ChangeNotifier {
  late UserModel _userData;

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

  void setFollow() {
    _userData.followed = !getUserData.followed;
    notifyListeners();
  }

  void setUserData() {
    _userData = UserModel.fromJson(user);
  }

  UserModel get getUserData => _userData;
}
