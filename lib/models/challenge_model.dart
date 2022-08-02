class ChallengeModel {
  int? id;
  String? name;
  String? desc;
  String? img;
  String? end_time;
  String? total_count;
  String? my_count;
  String? created_at;
  String? sub_count;
  String? rate;
  String? user_img;
  String? user_name;
  int? user_id;
  int? role_id;
  String? message;
  bool? is_time;
  bool? is_sub;
  bool? is_active;
  int? statusCode;
  ChallengeModel({
    this.id,
    this.name,
    this.desc,
    this.img,
    this.end_time,
    this.total_count,
    this.my_count,
    this.created_at,
    this.sub_count,
    this.message,
    this.rate,
    this.user_img,
    this.user_name,
    this.user_id,
    this.statusCode,
    this.role_id,
    this.is_time,
    this.is_sub,
    this.is_active,
  });
  // to convert data from json to dart object
  factory ChallengeModel.fromJson(Map<String, dynamic> user) => ChallengeModel(
        message: user['message'] ?? '',
        statusCode: user['status'] ?? 0,
        id: user['id'] ?? 0,
        name: user['name'] ?? '',
        desc: user['desc'] ?? '',
        img: user['img'] ?? '',
        end_time: user['end_time'] ?? '',
        role_id: user['role_id'] ?? 0,
        total_count: user['total_count'] ?? '',
        my_count: user['my_count'] ?? '',
        created_at: user['created_at'] ?? '',
        sub_count: user['sub_count'] ?? '',
        user_img: user['user_img'] ?? '',
        is_time: user['is_time'] ?? false,
        is_sub: user['is_sub'] ?? false,
        is_active: user['is_active'] ?? false,
      );
  factory ChallengeModel.fromJsonWithErrors(Map<String, dynamic> user) =>
      ChallengeModel(message: user['message'], statusCode: user['status'] ?? 0);
  //to convert data to json
  // Map<String, dynamic> toJson() => {
  //       'email': email,
  //       'password': password,
  //       'c_name': c_name,
  //       'mac': 'mac',
  //       'm_token': m_token
  //     };
}
