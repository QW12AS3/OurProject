import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/models/food_model.dart';

class EditMealViewModel with ChangeNotifier {
  bool _isLoading = false;
  List<int> _foods = [];

  void reset() {
    _foods.clear();
    _isLoading = false;
  }

  void setPickedFoods(List<int> ids) {
    _foods.addAll(ids);
  }

  void addToFoods(int i) {
    if (!_foods.contains(i)) _foods.add(i);
    notifyListeners();
  }

  void removeFromFoods(int i) {
    if (_foods.contains(i)) _foods.removeWhere((element) => element == i);
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get getIsLoading => _isLoading;
  List<int> get getPickedFoods => _foods;
}
