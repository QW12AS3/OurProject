// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/post_api.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/models/post_models.dart';

class PostsViewModel with ChangeNotifier {
  List<PostModel> _posts = [];
  int _page = 0;
  bool _isLoading = false;

  void setPage(int i) {
    _page = i;
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
  }

  void removePost(int id) {
    _posts.removeWhere((element) => element.postId == id);
    notifyListeners();
  }

  Future<void> setPosts(String lang) async {
    print('getting');
    setPage(getPage + 1);
    setIsLoading(true);
    List<PostModel> newPosts = await PostAPI().getPosts(lang, getPage);
    _posts.addAll(newPosts);
    if (newPosts.isEmpty) setPage(getPage - 1);
    setIsLoading(false);
    notifyListeners();
  }

  void clearPosts() {
    _posts.clear();
    notifyListeners();
  }

  Future<bool> savePost(
      {required String lang,
      required int postId,
      required BuildContext context}) async {
    final response = await PostAPI().savePost(lang: lang, postId: postId);
    if (response['success']) {
      return true;
    } else {
      showSnackbar(Text(response['message']), context);
      return false;
    }
  }

  Future<bool> likePost(
      {required String lang,
      required int postId,
      required BuildContext context,
      required int likeId}) async {
    final response =
        await PostAPI().likePost(lang: lang, postId: postId, likeId: likeId);
    if (response['success']) {
      return true;
    } else {
      showSnackbar(Text(response['message']), context);
      return false;
    }
  }

  Future<Map> votePost(
      {required String lang,
      required int postId,
      required BuildContext context,
      required int voteId}) async {
    final response =
        await PostAPI().votePost(lang: lang, postId: postId, voteId: voteId);
    if (response['success']) {
      showSnackbar(Text(response['message']), context);
      return {'update': true, 'newVotes': response['newVotes'] ?? []};
    } else {
      showSnackbar(Text(response['message']), context);
      return {'update': false, 'newVotes': response['newVotes'] ?? []};
    }
  }

  Future<void> reportPost({
    required String lang,
    required int postId,
    required BuildContext context,
  }) async {
    final response = await PostAPI().reportPost(lang: lang, postId: postId);
    if (response['success']) {
      showSnackbar(Text(response['message']), context);
    } else {
      showSnackbar(Text(response['message']), context);
    }
  }

  Future<bool> deletePost({
    required String lang,
    required int postId,
    required BuildContext context,
  }) async {
    final response = await PostAPI().deletePost(lang: lang, postId: postId);
    if (response['success']) {
      return true;
    } else {
      showSnackbar(Text(response['message']), context);
      return false;
    }
  }

  List<PostModel> get getPosts => _posts;
  bool get getIsLoading => _isLoading;
  int get getPage => _page;
}
