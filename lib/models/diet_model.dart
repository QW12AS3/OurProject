import 'package:home_workout_app/models/meal_model.dart';

class DietModel {
  int id = 0;
  String name = '';
  String description = '';
  List<MealModel> meals = [];
  int userId = 0;
  String userImg = '';
  String userFname = '';
  String userLname = '';

  DietModel();

  DietModel.fromJson(Map json) {}
}
