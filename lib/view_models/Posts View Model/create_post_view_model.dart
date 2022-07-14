// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/constants.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostViewModel with ChangeNotifier {
  PostTypes _selectedPostType = PostTypes.Normal;

  List<XFile>? _pickedImages = [];
  List<XFile>? _pickedVideo = [];

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      _pickedImages = pickedImages;
      notifyListeners();
    }
  }

  Future<void> pickVideos() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      if (_pickedVideo!.contains(pickedVideo) == false)
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
    notifyListeners();
  }

  PostTypes get getSelectedPostType => _selectedPostType;
  List<XFile>? get getPickedImages => _pickedImages;
  List<XFile>? get getPickedVideo => _pickedVideo;
}
