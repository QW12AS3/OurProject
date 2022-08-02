// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/diet_api.dart';
import 'package:home_workout_app/components.dart';

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

  Future<void> createMeal(
      {required String name,
      required BuildContext context,
      required String lang}) async {
    setIsLoading(true);
    _mealsId.clear();
    if (_breakfastMeals.isNotEmpty) _mealsId.add(_breakfastMeals);
    if (_lunchMeals.isNotEmpty) _mealsId.add(_lunchMeals);
    if (_snackMeals.isNotEmpty) _mealsId.add(_snackMeals);
    if (_dinnerMeals.isNotEmpty) _mealsId.add(_dinnerMeals);

    final response =
        await DietAPI().createDiet(name: name, meals: getMeals, lang: lang);
    if (response['success']) {
      showSnackbar(Text(response['message'].toString()), context);
      Navigator.pop(context);
    } else {
      showSnackbar(Text(response['message'].toString()), context);
    }
    setIsLoading(false);
  }

  void reset() {
    _breakfastMeals.clear();
    _dinnerMeals.clear();
    _lunchMeals.clear();
    _snackMeals.clear();
    _mealsId = [];
    _isLoading = false;
    notifyListeners();
  }

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
