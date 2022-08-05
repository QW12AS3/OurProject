import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/create_workout_api.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/create_workout_model.dart';
import 'package:image_picker/image_picker.dart';

class CreateworkoutViewModel with ChangeNotifier {
  Future<List<CreateworkoutModel>>? futureworkoutList;
  List<String>? dropDownList = [];
  String dropDownNewValue = '';
  List<CreateworkoutModel>? ConvertedFutureworkoutList;
  bool fetchedList = false;
  getData(String lang, int page) async {
    try {
      futureworkoutList = CreateWorkoutAPI().getExercisesList(lang);
      ConvertedFutureworkoutList = await futureworkoutList;
      // print(ConvertedFutureworkoutList!.length);
      if (ConvertedFutureworkoutList != null) {
        for (var i = 0; i < ConvertedFutureworkoutList!.length; i++) {
          dropDownList?.add(ConvertedFutureworkoutList![i].name.toString());
          // dropDownList!.insert('v');
          // print(dropDownList![i]);
          print(ConvertedFutureworkoutList![i].id.toString());
          // dropDownList![i] = '$i';
          print('dddddddddddd');
          print(dropDownList![i]);
        }
        dropDownNewValue = ConvertedFutureworkoutList![0].name.toString();
        // for (var i = 0; i < ConvertedFutureworkoutList!.length; i++) {
        //   print(ConvertedFutureworkoutList![i].id);
        // }
      }

      // for (int i = 0; i < dropDownList.length; i++) {
      //   // dropDownList?.add(ConvertedFutureworkoutList![i].name.toString());
      //   print(dropDownList![i]);
      // }
      // ConvertedFutureworkoutList.forEach((element) async {
      //   dropDownList?.add(ConvertedFutureworkoutList!(element).toString());
      //   // dropDownList.add(l(element));
      // });
      fetchedList = true;
      notifyListeners();
      return futureworkoutList;
    } catch (e) {
      print('drop down in create workout error $e');
    }
  }
}
