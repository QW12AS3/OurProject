import 'package:home_workout_app/models/meal_model.dart';

class DietModel {
  int id = 0;
  String name = '';
  String description = '';
  List<Map> meals = [];
  int userId = 0;
  String userImg = '';
  String userFname = '';
  String userLname = '';
  String createAt = '';

  DietModel();

  DietModel.fromJson(Map json) {
    name = json['name'] ?? '';
    userId = json['created_by']['id'] ?? 0;
    userImg = json['created_by']['prof_img_url'] ?? '';
    userFname = json['created_by']['f_name'] ?? '';
    userLname = json['created_by']['l_name'] ?? '';
    createAt = json['created_by']['created_at'] ?? '';

    final mealsL = json['schedule'] as List;
    mealsL.forEach((element) {
      final m = [];
      final l = element['meals'] as List;
      l.forEach((element) {
        m.add(MealModel.fromJsonForDiet(element));
      });

      meals.add(
        {
          'day': element['day'] ?? '',
          'meals': m,
        },
      );
    });
  }
}
