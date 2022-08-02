// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';

class CreateDietViewModel with ChangeNotifier {
  bool _isLoading = false;
  List<List> _mealsId = [];
  List<int> _breakfastMeals = [];
  List<int> _lunchMeals = [];
  List<int> _dinnerMeals = [];
  List<int> _snackMeals = [];

  void addToMeals(int i, String type) {
    print('add $i');

    switch (type) {
      case 'Breakfast':
        _breakfastMeals.add(i);
        break;
      case 'Lunch':
        _lunchMeals.add(i);
        break;
      case 'Dinner':
        _dinnerMeals.add(i);
        break;
      case 'Snack':
        _snackMeals.add(i);
        break;
      default:
    }

    notifyListeners();
  }

  void removeFromMeals(int i, String type) {
    print('remove $i $type');
    switch (type) {
      case 'Breakfast':
        _breakfastMeals.removeWhere((element) => element == i);
        print(_breakfastMeals);
        break;
      case 'Lunch':
        _lunchMeals.removeWhere((element) => element == i);
        break;
      case 'Dinner':
        _dinnerMeals.removeWhere((element) => element == i);
        break;
      case 'Snack':
        _snackMeals.removeWhere((element) => element == i);
        break;
      default:
    }

    notifyListeners();
  }

  // bool checkIfContain(int i) {
  //   bool isContain = false;
  //   if (_breakfastMeals.contains(i))
  //     return true;
  //   else if (_dinnerMeals.contains(i))
  //     return true;
  //   else if (_lunchMeals.contains(i))
  //     return true;
  //   else if (_snackMeals.contains(i))
  //     return true;
  //   else {
  //     return isContain;
  //   }
  // }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get getIsLoading => _isLoading;
  List<List> get getMeals => _mealsId;
  List get getBreakfastMeals => _breakfastMeals;
  List get getLunchMeals => _lunchMeals;
  List get getDinnerMeals => _dinnerMeals;
  List get getSnacksMeals => _snackMeals;
}
