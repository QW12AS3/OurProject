class WorkoutListModel {
  int? id;
  String? name;
  String? equipment;
  int? user_id;
  int? predicted_burnt_calories;
  String? message;
  int? excersise_count;
  int? difficulty;
  int? length;
  int? statusCode;
  String? subs;
  String? workout_image_url;
  String? prof_img_url;
  String? created_at;

  String? f_name;
  WorkoutListModel(
      {this.id,
      this.name,
      this.message,
      this.equipment,
      this.user_id,
      this.statusCode,
      this.predicted_burnt_calories,
      this.difficulty,
      this.length,
      this.subs,
      this.workout_image_url,
      this.excersise_count,
      this.f_name,
      this.prof_img_url,
      this.created_at});
  // to convert data from json to dart object
  factory WorkoutListModel.fromJson(Map<String, dynamic> user) =>
      WorkoutListModel(
        // message: user['message'] ?? '',
        // statusCode: user['status'] ?? 0,
        id: user['id'] ?? 0,
        name: user['name'] ?? '',
        equipment: user['equipment'] ?? '',
        f_name: user['user_id']['f_name'] ?? '',
        prof_img_url: user['user_id']['prof_img_url'] ?? '',
        user_id: user['user_id']['id'] ?? '',
        predicted_burnt_calories: user['predicted_burnt_calories'] ?? 0,
        excersise_count: user['excersise_count'] ?? 0,
        difficulty: user['difficulty'] ?? 0,
        length: user['length'] ?? 0,
        workout_image_url: user['workout_image_url'] ?? '',
        created_at: user['created_at'] ?? '',
      );
  // factory WorkoutListModel.fromJsonForParticipate(Map<String, dynamic> user) =>
  //     WorkoutListModel(
  //       message: user['message'] ?? '',
  //       statusCode: user['status'] ?? 0,
  //       is_sub: user['is_sub'] ?? false,
  //       subs: user['subs'] ?? '',
  //     );
  factory WorkoutListModel.fromCategoriesJson(Map<String, dynamic> user) =>
      WorkoutListModel(
        // message: user['message'] ?? '',
        // statusCode: user['status'] ?? 0,
        id: user['id'] ?? 0,
        name: user['name'] ?? '',
        // img: user['img'] ?? '',
        //  ca: user['ca'] ?? '',
      );
  factory WorkoutListModel.fromJsonWithErrors(Map<String, dynamic> user) =>
      WorkoutListModel(
          message: user['message'], statusCode: user['status'] ?? 0);
  //to convert data to json
  // Map<String, dynamic> toJson() => {
  //       'email': email,
  //       'password': password,
  //       'c_name': c_name,
  //       'mac': 'mac',
  //       'm_token': m_token
  //     };
}
