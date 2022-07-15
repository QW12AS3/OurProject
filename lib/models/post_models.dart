import '../constants.dart';

class PostModel {
  String pubName = '';
  int pubId = 0;
  String pubImageUrl = '';
  String pubRole = '';
  String title = '';

  String createdAt = '';
  int postId = 0;
  List imagesUrl = [];
  List videosUrl = [];
  int commentsCount = 0;
  int type = 0;
  Map reacts = {
    'type1': 0,
    'type2': 0,
    'type3': 0,
    'type4': 0,
    'type5': 0,
  };
  List choices = [];
  PostModel();

  PostModel.fromJson(Map json) {
    postId = json['post_main_data']['id'] ?? 0;
    pubId = json['post_main_data']['user_id'] ?? 0;
    title = json['post_main_data']['text'] ?? '';
    type = json['post_main_data']['type'] ?? 0;
    createdAt = json['post_main_data']['created_at'] ?? '';
    commentsCount = json['post_main_data']['comments'] ?? 0;

    pubName = json['user_data']['name'] ?? '';
    pubImageUrl = json['user_data']['img'] ?? '';
    pubRole = json['user_data']['role'] ?? '';

    reacts = json['posts_likes'] ??
        {
          'type1': 0,
          'type2': 0,
          'type3': 0,
          'type4': 0,
          'type5': 0,
        };

    imagesUrl = json['media']['imgs'] ?? [];
    imagesUrl.forEach((element) {
      element['url'] = '$ip/${element['url']}';
    });
    videosUrl = json['media']['vids'] ?? [];
    videosUrl.forEach((element) {
      element['url'] = '$ip/${element['url']}';
    });
    print('urlsssssss: $videosUrl');
    choices = json['votes'] ?? [];
  }
}

// class PollPostModel {
//   String pubName = '';
//   int pubId = 0;
//   String title = '';
//   String createdAt = '';
//   int postId = 0;

//   PollPostModel();

//   PollPostModel.fromJson(Map json) {}
// }
