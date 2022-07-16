// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/comments_api.dart';
import 'package:home_workout_app/Api%20services/post_api.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/models/comments_model.dart';

class CommentsViewModel with ChangeNotifier {
  List<CommentsModel> _comments = [];

  bool _isLoading = false;
  bool _isdeleteLoading = false;

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void setIsdeleteLoading(value) {
    _isdeleteLoading = value;
    notifyListeners();
  }

  Future<void> setComments({required int id, required String lang}) async {
    setIsLoading(true);
    _comments = await CommentsApi().getComments(id: id, lang: lang);
    setIsLoading(false);

    notifyListeners();
  }

  Future<void> sendComment(
      {required int id,
      required String lang,
      required String comment,
      required BuildContext context}) async {
    setIsLoading(true);
    final response = await CommentsApi()
        .sendCommet(comment: comment, postId: id, lang: lang);
    if (response['success'])
      await setComments(id: id, lang: lang);
    else
      showSnackbar(Text(response['message']), context);
    setIsLoading(false);
  }

  Future<void> deleteComment(
      {required int commentId,
      required int postId,
      required String lang,
      required BuildContext context}) async {
    setIsdeleteLoading(true);
    final response =
        await CommentsApi().deleteComment(lang: lang, commentId: commentId);
    if (response['success'])
      await setComments(id: postId, lang: lang);
    else
      showSnackbar(Text(response['message']), context);
    setIsdeleteLoading(false);
  }

  Future<void> updateComment(
      {required int commentId,
      required int postId,
      required String comment,
      required String lang,
      required BuildContext context}) async {
    final response = await CommentsApi()
        .updateComment(lang: lang, commentId: commentId, comment: comment);
    if (response['success'])
      await setComments(id: postId, lang: lang);
    else
      showSnackbar(Text(response['message']), context);
  }

  List<CommentsModel> get getComments => _comments;
  bool get getIsLoading => _isLoading;
  bool get getdeleteIsLoading => _isdeleteLoading;
}
