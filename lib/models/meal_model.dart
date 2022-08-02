import 'package:home_workout_app/models/food_model.dart';

class MealModel {
  String type = '';
  int id = 0;
  int day = 0;
  int ownerId = 0;
  double calories = 0;
  String description = '';
  List<FoodModel> foods = [];
  MealModel();
  MealModel.fromJson(Map json) {
    print(json);
    type = json['type'] ?? 'Breakfast';
    id = json['id'] ?? 0;
    print('iddddddddddddd'+id.toString());
    //day = json['day'] ?? 0;
    //ownerId = json['user_id'] ?? 0;
    calories = double.tryParse(json['calorie_count'].toString()) ?? 0;
    description = json['description'];
    // final foodsData = json['data']['foods'] as List;

    // foodsData.forEach((element) {
    //   foods.add(FoodModel.fromJson(element));
    // });
  }
}
