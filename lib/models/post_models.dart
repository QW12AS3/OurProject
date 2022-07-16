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

  int myVote = -1;
  int myLike = -1;
  bool on_hold = false;
  bool is_saved = false;

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

    if (pubImageUrl.substring(0, 4) != 'http') {
      pubImageUrl = '$ip/$pubImageUrl';
    }
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

    is_saved = json['post_main_data']['is_saved'] ?? false;
    on_hold = json['post_main_data']['on_hold'] ?? false;
    myVote = json['post_main_data']['my_vote'] ?? -1;
    myLike = json['post_main_data']['my_like'] ?? -1;

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
