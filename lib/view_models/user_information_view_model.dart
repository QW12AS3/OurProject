import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';

class UserInformationViewModel with ChangeNotifier {
  var gender;
  double age = 10;

  void changeGender(Gender selectedGender) {
    gender = selectedGender;
    notifyListeners();
  }

  void changeAge(double selectedAge) {
    age = selectedAge;
    notifyListeners();
  }
}
