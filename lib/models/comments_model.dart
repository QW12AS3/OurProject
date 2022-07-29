import '../constants.dart';

class CommentsModel {
  String owner = '';
  String ownerImageUrl = '';
  String comment = '';
  String createdAt = '';
  int id = 0;
  int ownerId = 0;
  int reports = 0;

  CommentsModel();
  CommentsModel.fromJson(Map<String, dynamic> json) {
    owner = json['name'];
    comment = json['comment'];
    createdAt = json['created_at'];
    id = json['comment_id'];
    ownerId = json['user_id'];
    ownerImageUrl = json['img'];
    if (ownerImageUrl.substring(0, 4) != 'http') {
      ownerImageUrl = '$ip/$ownerImageUrl';
    }
    reports = json['reports'] ?? 0;
  }
}
