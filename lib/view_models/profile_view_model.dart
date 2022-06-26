// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/models/user_model.dart';

class ProfileViewModel with ChangeNotifier {
  late UserModel _userData;

  bool _infoWidgetVisible = false;

  setInfoWidgetVisible(bool value) {
    _infoWidgetVisible = value;

    notifyListeners();
  }

  Map<dynamic, dynamic> user = {
    'id': 1,
    'data': {
      'name': 'Omar',
      'imageUrl':
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg',
      'role': 'Manager'
    }
  };

  void setUserData() {
    _userData = UserModel.fromJson(user);
  }

  UserModel get getUserData => _userData;
  bool get getInfoWidgetVisible => _infoWidgetVisible;
}
