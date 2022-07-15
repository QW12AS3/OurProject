// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/post_api.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostViewModel with ChangeNotifier {
  PostTypes _selectedPostType = PostTypes.Normal;
  bool _isLoading = false;

  List<XFile>? _pickedImages = [];
  List<XFile>? _pickedVideo = [];

  List<String> _choices = [];

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void addChoice(String value, BuildContext context) {
    if (value.isEmpty) return;
    if (_choices.contains(value)) {
      showSnackbar(const Text('You have already added this choice'), context);
      return;
    } else if (_choices.length == 10) {
      showSnackbar(const Text("You can't add more than 10 choices"), context);
      return;
    } else {
      _choices.add(value);
      notifyListeners();
    }
  }

  void removeChoice(String value) {
    _choices.remove(value);
    notifyListeners();
  }

  void removePhoto(String path) {
    _pickedImages!.removeWhere((element) => element.path == path);
    notifyListeners();
  }

  void removeVideo(String path) {
    _pickedVideo!.removeWhere((element) => element.path == path);
    notifyListeners();
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(imageQuality: 25);
    if (pickedImages != null) {
      _pickedImages = pickedImages;
      notifyListeners();
    }
  }

  Future<void> pickVideos() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      _pickedVideo!.add(pickedVideo);
      notifyListeners();
    }
  }

  void setSelectedPostType(PostTypes type) {
    if (type != _selectedPostType) {
      _selectedPostType = type;
      notifyListeners();
    }
  }

  void resetPicked() {
    _pickedImages!.clear();
    _pickedVideo!.clear();
    _choices.clear();
    notifyListeners();
  }

  Future<void> postNormal() async {}

  Future<void> postPoll(
      {required String title,
      required String lang,
      required BuildContext ctx,
      required int type}) async {
    setIsLoading(true);
    if (getChoices.length < 2 && type == 3) {
      setIsLoading(false);
      showSnackbar(const Text('You have to add at least two choices'), ctx);
      notifyListeners();

      return;
    }
    if (title.isEmpty) {
      setIsLoading(false);
      showSnackbar(const Text('You have to add a text'), ctx);
      notifyListeners();

      return;
    }
    final response = await PostAPI()
        .postPoll(type: type, title: title, choices: getChoices, lang: lang);
    if (response['success']) {
      showSnackbar(Text(response['message']), ctx);
      Navigator.pop(ctx);
    } else {
      showSnackbar(Text(response['message']), ctx);
    }
    setIsLoading(false);
    notifyListeners();
  }

  PostTypes get getSelectedPostType => _selectedPostType;
  List<XFile>? get getPickedImages => _pickedImages;
  List<XFile>? get getPickedVideo => _pickedVideo;
  List<String> get getChoices => _choices;
  bool get getIsLoading => _isLoading;
}
