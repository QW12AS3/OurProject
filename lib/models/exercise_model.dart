import 'package:home_workout_app/constants.dart';

class exerciseModel {
  int? id;
  String? name;
  String? message;

  String? exercise_img;
  String? end_time;
  String? time;
  String? count;
  String? ex_id;
  String? desc;
  String? categorie_id;
  String? equipment;
  String? difficulty;
  List? excersisesList;
  int? statusCode;
  exerciseModel(
      {this.id,
      this.name,
      this.message,
      this.statusCode,
      this.end_time,
      this.time,
      this.count,
      this.ex_id,
      this.desc,
      this.exercise_img,
      this.categorie_id,
      this.equipment,
      this.difficulty,
      this.excersisesList});

  // exerciseModel.fromJson(Map json) {
  //   print(json);
  //   print(json['image_url']);
  //   description = json['description'] ?? '';
  //   name = json['name'] ?? '';
  //   imageUrl = json['exercise_image_url'] ?? '';
  //   if (imageUrl.substring(0, 4) != 'http') imageUrl = '$ip/$imageUrl';
  //   print(imageUrl);
  //   id = json['id'] ?? 0;
  //   calories = int.tryParse(json['calories'].toString()) ?? 0;
  //   //ownerId = json['data']['user_id'] ?? 0;
  // }
  factory exerciseModel.fromExercisesJson(Map<String, dynamic> user) =>
      exerciseModel(
        // message: user['message'] ?? '',
        // statusCode: user['status'] ?? 0,
        id: user['id'] ?? 0,
        name: user['name'] ?? '',
        desc: user['description'] ?? '',
        exercise_img: user['excersise_media_url'] ?? '',
        //  ca: user['ca'] ?? '',
      );
}
