import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/post_api.dart';
import 'package:home_workout_app/models/post_models.dart';

class PostsViewModel with ChangeNotifier {
  List<PostModel> _posts = [];

  bool _isLoading = false;

  void setIsLoading(value) {
    _isLoading = value;
  }

  Future<void> setPosts(String lang) async {
    setIsLoading(true);
    _posts = await PostAPI().getPosts(lang);
    setIsLoading(false);
    notifyListeners();
  }

  List<PostModel> get getPosts => _posts;
  bool get getIsLoading => _isLoading;
}
