import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/create_workout_api.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/create_workout_model.dart';
import 'package:image_picker/image_picker.dart';

class CreateworkoutViewModel with ChangeNotifier {
  Future<List<CreateworkoutModel>>? futureworkoutList;
  Future<List<CreateworkoutModel>>? futureExercisesList;
  List<String>? dropDownList = [];
  String dropDownNewValue = '';
  List<String>? equipmentDropDownList = [
    'Recomended',
    'Required',
    'Not required'
  ];
  List<String>? difficultyDropDownList = ['Easy', 'Medium', 'Hard'];
  String? equipmentDropDownNewValue = 'Recomended';
  String? difficultyDropDownNewValue = 'Easy';

  List<CreateworkoutModel>? ConvertedFutureCategoriesList;
  List<CreateworkoutModel>? ConvertedFutureExercisesList;
  bool fetchedList = false;
  bool fetchedExercisesList = false;

  List<int> pickedExercisesIDs = [];

  reset() {
    fetchedList = false;
    dropDownNewValue = '';
    dropDownList = [];
    ConvertedFutureCategoriesList?.clear();
    ConvertedFutureExercisesList?.clear();
    fetchedExercisesList = false;
  }

  void addToExercises(int i) {
    if (!pickedExercisesIDs.contains(i)) pickedExercisesIDs.add(i);
    notifyListeners();
  }

  // void addToFoods(int i) {
  //   if (!_pickedFoodsIDs.contains(i)) _pickedFoodsIDs.add(i);
  //   notifyListeners();
  // }

  getData(String lang, int page) async {
    try {
      futureworkoutList = CreateWorkoutAPI().getCategoriesList(lang);
      ConvertedFutureCategoriesList = await futureworkoutList;
      // print(ConvertedFutureCategoriesList!.length);
      if (ConvertedFutureCategoriesList != null) {
        for (var i = 0; i < ConvertedFutureCategoriesList!.length; i++) {
          dropDownList?.add(ConvertedFutureCategoriesList![i].name.toString());
          // dropDownList!.insert('v');
          // print(dropDownList![i]);
          print(ConvertedFutureCategoriesList![i].id.toString());
          // dropDownList![i] = '$i';
          print('dddddddddddd');
          print(dropDownList![i]);
        }
        dropDownNewValue = ConvertedFutureCategoriesList![0].name.toString();
      }
      fetchedList = true;
      notifyListeners();
      return futureworkoutList;
    } catch (e) {
      print('drop down in create workout error $e');
    }
  }

  getExercisesData(String lang) async {
    try {
      ConvertedFutureExercisesList =
          await CreateWorkoutAPI().getExercisesList(lang);
      // futureExercisesList;
      // print(ConvertedFutureCategoriesList!.length);
      // if (ConvertedFutureCategoriesList != null) {
      for (var i = 0; i < ConvertedFutureExercisesList!.length; i++) {
        print(ConvertedFutureExercisesList![i].id.toString());
        // dropDownList?.add(ConvertedFutureCategoriesList![i].name.toString());
        // // dropDownList!.insert('v');
        // // print(dropDownList![i]);
        // print(ConvertedFutureCategoriesList![i].id.toString());
        // // dropDownList![i] = '$i';
        // print('dddddddddddd');
        // print(dropDownList![i]);
      }
      //   dropDownNewValue = ConvertedFutureCategoriesList![0].name.toString();
      // }
      // fetchedExercisesList = true;
      setfetchedExercisesList();
      notifyListeners();
      // return futureExercisesList;
    } catch (e) {
      print('get exercises in create workout error $e');
    }
  }

  postWorkoutInfo(String nameVal, String categoryVal, String equipmentVal,
      String difficultyVal, List exercisesVal, String lang) async {
    CreateworkoutModel? result;
    return await CreateWorkoutAPI.CreateWorkout(
        CreateworkoutModel(
            name: nameVal,
            categorie_id: categoryVal,
            equipment: equipmentVal,
            difficulty: difficultyVal,
            excersisesList: exercisesVal),
        lang);
  }

  setdropDownNewValue(String dropDownNewVal) {
    dropDownNewValue = dropDownNewVal;
    notifyListeners();
  }

  setfetchedExercisesList() {
    fetchedExercisesList = true;
    notifyListeners();
  }

  setequipmentDropDownNewValue(String dropDownNewVal) {
    equipmentDropDownNewValue = dropDownNewVal;
    notifyListeners();
  }

  setdifficultyDropDownNewValue(String dropDownNewVal) {
    difficultyDropDownNewValue = dropDownNewVal;
    notifyListeners();
  }

  getIdOfDropDownValue() {
    for (int i = 0; i < ConvertedFutureCategoriesList!.length; i++) {
      if (dropDownNewValue == ConvertedFutureCategoriesList![i].name) {
        return ConvertedFutureCategoriesList![i].id;
      }
    }
  }

  getIdOfDifficultyDropDownValue() {
    if (difficultyDropDownNewValue == 'Easy') {
      return 1;
    } else if (difficultyDropDownNewValue == 'Medium') {
      return 2;
    } else {
      return 3;
    }
  }

  String? checkName(String name, String lang) {
    if (name.isEmpty) {
      return lang == 'en' ? ' Enter name' : ' أدخل الاسم ';
    } else {
      return null;
    }
  }

  bool get getIsFetched => fetchedExercisesList;
  List<CreateworkoutModel>? get exercisesList => ConvertedFutureExercisesList;
}
