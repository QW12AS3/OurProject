import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/post_api.dart';
import 'package:home_workout_app/models/post_models.dart';

class PostsViewModel with ChangeNotifier {
  List<PostModel> _posts = [];

  Future<void> setPosts(String lang) async {
    _posts = await PostAPI().getPosts(lang);
    notifyListeners();
  }

  List<PostModel> get getPosts => _posts;
}
