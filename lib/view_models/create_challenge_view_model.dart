import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/create_challenge_api.dart';
import 'package:home_workout_app/models/create_challenge_model.dart';
import 'package:image_picker/image_picker.dart';

class CreateChallengesViewModel with ChangeNotifier {
  XFile userImage = XFile('');
  Future<List<CreateChallengeModel>>? futurechallengesList;
  List<String>? dropDownList = [];
  String dropDownNewValue = '';
  List<CreateChallengeModel>? ConvertedFuturechallengesList;
  bool fetchedList = false;
  Future<void> changePhoto(ImageSource src) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: src);
    if (pickedImage != null) {
      userImage = pickedImage;
    }
    notifyListeners();
  }

  postChallengeInfo(
      String nameVal,
      String end_timeVal,
      String countVal,
      String ex_idVal,
      String timeVal,
      XFile imgVal,
      String descVal,
      String lang) async {
    CreateChallengeModel? result;
    try {
      await CreateChallengeAPI.createChallenge(
              CreateChallengeModel(
                  name: nameVal,
                  end_time: end_timeVal,
                  time: timeVal,
                  count: countVal,
                  ex_id: ex_idVal,
                  img: imgVal,
                  desc: descVal),
              lang)
          .then((value) {
        print(value);
        result = value;
      });
    } catch (e) {
      print("create challenge in GeneralChallengesViewModel error: $e");
    }

    return result;
  }

  getChallengesList(String lang) {
    return CreateChallengeAPI().getChallengesList(lang);
  }

  setdropDownNewValue(String dropDownNewVal) {
    dropDownNewValue = dropDownNewVal;
    notifyListeners();
  }

  getIdOfDropDownValue() {
    for (int i = 0; i < ConvertedFuturechallengesList!.length; i++) {
      if (dropDownNewValue == ConvertedFuturechallengesList![i].name) {
        return ConvertedFuturechallengesList![i].id;
      }
    }
  }

  getData(String lang, int page) async {
    futurechallengesList = CreateChallengeAPI().getChallengesList(lang);
    ConvertedFuturechallengesList = await futurechallengesList;
    // print(ConvertedFuturechallengesList!.length);
    if (ConvertedFuturechallengesList != null) {
      for (var i = 0; i < ConvertedFuturechallengesList!.length; i++) {
        dropDownList?.add(ConvertedFuturechallengesList![i].name.toString());
        // dropDownList!.insert('v');
        print(dropDownList![i]);
        print(ConvertedFuturechallengesList![i].name.toString());
        // dropDownList![i] = '$i';
        print('dddddddddddd');
        print(dropDownList![i]);
      }
      dropDownNewValue = ConvertedFuturechallengesList![0].name.toString();
      for (var i = 0; i < ConvertedFuturechallengesList!.length; i++) {
        print(ConvertedFuturechallengesList![i].id);
      }
    }

    // for (int i = 0; i < dropDownList.length; i++) {
    //   // dropDownList?.add(ConvertedFuturechallengesList![i].name.toString());
    //   print(dropDownList![i]);
    // }
    // ConvertedFuturechallengesList.forEach((element) async {
    //   dropDownList?.add(ConvertedFuturechallengesList!(element).toString());
    //   // dropDownList.add(l(element));
    // });
    fetchedList = true;
    notifyListeners();
    return futurechallengesList;
  }
}
