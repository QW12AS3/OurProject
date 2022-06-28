class UserModel {
  late String id;
  late String name;
  late String imageUrl;
  late String role;
  late int enteredWorkouts;
  late int finishedWorkouts;

  UserModel(this.name, this.imageUrl, this.role);

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['data']['name'] ?? '';
    imageUrl = json['data']['imageUrl'] ?? '';
    role = json['data']['role'] ?? '';
    id = json['id'].toString();
    enteredWorkouts = json['data']['enteredWorkouts'] ?? 0;
    finishedWorkouts = json['data']['finishedWorkouts'] ?? 0;
  }
}
