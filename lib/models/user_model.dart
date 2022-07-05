import 'package:home_workout_app/constants.dart';
import 'package:intl/intl.dart';

class UserModel {
  late String id;
  late String fname;
  late String lname;
  late String imageUrl;
  late String role;
  late int roleId;
  late int enteredWorkouts;
  late int finishedWorkouts;
  late String bio;
  late Gender gender;
  late DateTime birthdate;
  late String countryName;
  late String email;
  late bool followed;

  UserModel(
      this.fname,
      this.lname,
      this.imageUrl,
      this.role,
      this.bio,
      this.gender,
      this.enteredWorkouts,
      this.finishedWorkouts,
      this.id,
      this.birthdate,
      this.countryName,
      this.email,
      this.roleId,
      this.followed);

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    fname = json['data']['fname'] ?? '';
    lname = json['data']['lname'] ?? '';
    imageUrl = json['data']['imageUrl'] ?? '';
    role = json['data']['role'] ?? '';
    id = json['id'].toString();
    enteredWorkouts = json['data']['enteredWorkouts'] ?? 0;
    finishedWorkouts = json['data']['finishedWorkouts'] ?? 0;
    bio = json['data']['bio'];
    gender = json['data']['gender'] == 'male' ? Gender.male : Gender.female;
    birthdate = DateFormat("yyyy-MM-dd").parse(json['data']['birthdate']);
    countryName = json['data']['country'];
    email = json['data']['email'] ?? '';
    roleId = json['data']['role_id'];
    followed = json['data']['followed'] ?? false;
  }
}
