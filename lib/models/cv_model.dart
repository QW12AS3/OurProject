import '../constants.dart';

class CVModel {
  String desc = '';
  int roleId = 0;
  String fileUrl = '';
  bool accept = false;
  int ownerId = 0;
  int id = 0;
  String role = '';

  CVModel();

  CVModel.fromJson(Map json) {
    desc = json['data'][0]['description'] ?? '';
    roleId = json['data'][0]['role_id'] ?? 0;
    fileUrl = json['data'][0]['cv_path'] ?? '';
    fileUrl = '$ip/$fileUrl';

    accept = json['data'][0]['acception'] == 1 ? true : false;
    ownerId = json['data'][0]['user_id'] ?? 0;
    id = json['data'][0]['id'] ?? 0;
    role = json['data'][0]['role'] ?? '';
  }
}
