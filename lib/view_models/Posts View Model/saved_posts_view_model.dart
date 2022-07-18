import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/post_api.dart';
import 'package:home_workout_app/models/post_models.dart';

class SavedPostsViewModel with ChangeNotifier {
  List<PostModel> _savedPosts = [];
  bool _isLoading = false;
  int _page = 0;

  void setPage(int i) {
    _page = i;
    notifyListeners();
  }

  void clearSavedPosts() {
    _savedPosts.clear();
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> setSavedPosts(
      {required String lang, required BuildContext context}) async {
    setPage(getPage + 1);
    setIsLoading(true);
    List<PostModel> newPosts = await PostAPI().getSavedPosts(lang, getPage);
    _savedPosts.addAll(newPosts);
    if (newPosts.isEmpty) setPage(getPage - 1);
    print(_savedPosts);
    setIsLoading(false);
  }

  List<PostModel> get getSavedPosts => _savedPosts;
  bool get getIsLoading => _isLoading;
  int get getPage => _page;
}
