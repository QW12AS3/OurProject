class NormalPostModel {
  String pubName = '';
  int pubId = 0;
  String title = '';
  String createdAt = '';
  int postId = 0;
  List imagesUrl = [];
  List videosUrl = [];
  Map reacts = {
    'type1': 0,
    'type2': 0,
    'type3': 0,
    'type4': 0,
  };
  NormalPostModel();

  NormalPostModel.fromJson(Map json) {}
}

class PollPostModel {
  String pubName = '';
  int pubId = 0;
  String title = '';
  String createdAt = '';
  int postId = 0;

  PollPostModel();

  PollPostModel.fromJson(Map json) {}
}
