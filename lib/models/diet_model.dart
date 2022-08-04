import 'package:home_workout_app/constants.dart';
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
  double caloriesCount = 0;
  double mealsCount = 0;

  DietModel();

  DietModel.fromJson(Map json) {
    name = json['name'] ?? '';
    userId = json['created_by']['id'] ?? 0;
    userImg = json['created_by']['prof_img_url'] ?? '';
    userFname = json['created_by']['f_name'] ?? '';
    userLname = json['created_by']['l_name'] ?? '';
    createAt = json['created_by']['created_at'] ?? '';
    caloriesCount = json[''] ?? 0;
    mealsCount = json[''] ?? 0;

    // final mealsL = json['schedule'] as List;
    // mealsL.forEach((element) {
    //   final m = [];
    //   final l = element['meals'] as List;
    //   l.forEach((element) {
    //     m.add(MealModel.fromJsonForDiet(element));
    //   });

    //   meals.add(
    //     {
    //       'day': element['day'] ?? '',
    //       'meals': m,
    //     },
    //   );
    // });
  }

  DietModel.fromJsonForFull(Map json) {
    name = json['name'] ?? '';
    userId = json['created_by']['id'] ?? 0;
    userImg = json['created_by']['prof_img_url'] ?? '';
    if (userImg.substring(0, 4) != 'http') userImg = '$ip/$userImg';
    print(userImg);
    userFname = json['created_by']['f_name'] ?? '';
    userLname = json['created_by']['l_name'] ?? '';
    createAt = json['created_by']['created_at'] ?? '';
    caloriesCount = json[''] ?? 0;
    mealsCount = json[''] ?? 0;

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
