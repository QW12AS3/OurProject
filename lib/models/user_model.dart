import 'package:home_workout_app/constants.dart';
import 'package:intl/intl.dart';

class UserModel {
  String id = '';
  String fname = '';
  String lname = '';
  String imageUrl = '';
  String role = '';
  int roleId = 0;
  int enteredWorkouts = 0;
  int finishedWorkouts = 0;
  String bio = '';
  Gender gender = Gender.male;
  DateTime birthdate = DateTime.now();
  String countryName = '';
  String email = '';
  bool followed = false;
  String createdAt = '';
  bool isBlocked = false;
  int followers = 0;
  int followings = 0;
  bool i_block = false;

  UserModel(
      // this.fname,
      // this.lname,
      // this.imageUrl,
      // this.role,
      // this.bio,
      // this.gender,
      // this.enteredWorkouts,
      // this.finishedWorkouts,
      // this.id,
      // this.birthdate,
      // this.countryName,
      // this.email,
      // this.roleId,
      // this.followed,
      );

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    fname = json['data']['user']['fname'] ?? '';
    lname = json['data']['user']['lname'] ?? '';
    imageUrl = json['data']['user']['profile_img'] ?? '';

    role = json['data']['user']['role_name'] ?? '';
    id = json['data']['user']['id'].toString();
    // enteredWorkouts = json['data']['user']['enteredWorkouts'] ?? 0;
    // finishedWorkouts = json['data']['user']['finishedWorkouts'] ?? 0;
    bio = json['data']['user']['bio'] ?? '';
    gender =
        json['data']['user']['gender'] == 'male' ? Gender.male : Gender.female;
    birthdate = DateFormat('yyyy-MM-dd')
        .parse(json['data']['user']['birth_date'] ?? '');
    countryName = json['data']['user']['country'] ?? '';
    email = json['data']['user']['email'] ?? '';
    roleId = json['data']['user']['role_id'] ?? 0;

    followed = json['data']['is_following'] ?? false;
    isBlocked = json['data']['is_blocked'] ?? false;
    followers = json['data']['followers'] ?? 0;
    followings = json['data']['following'] ?? 0;
    i_block = json['data']['I_block'];
  }
}
