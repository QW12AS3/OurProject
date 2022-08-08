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
    'Recommended',
    'Required',
    'Not Required'
  ];
  List<String>? difficultyDropDownList = ['Easy', 'Medium', 'Hard'];
  String? equipmentDropDownNewValue = 'Recommended';
  String? difficultyDropDownNewValue = 'Easy';

  bool switchValue = false;

  List<CreateworkoutModel>? ConvertedFutureCategoriesList;
  List<CreateworkoutModel>? ConvertedFutureExercisesList;
  bool fetchedList = false;
  // bool fetchedExercisesList = false;

  List _pickedExercisesIDs = [];

  List piickedExc = [];

  List<Map<int, int>> pickedExercisesIDsAndCount = [];
  // var f<String,dynamic> = {};
  // List<f, f> l;

  bool _isLoading = false;

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  reset() {
    fetchedList = false;
    dropDownNewValue = '';
    dropDownList = [];
    ConvertedFutureCategoriesList?.clear();
    ConvertedFutureExercisesList?.clear();
    // fetchedExercisesList = false;
  }

  void addToExercises(int i) {
//     [{
//       'id':1,'isTime':true,'value':50,
//     }
// ]

    bool exist = false;
    _pickedExercisesIDs.forEach((element) {
      if (element['id'] == i) exist = true;
    });

    if (!exist) {
      _pickedExercisesIDs.add({'id': i, 'isTime': false, 'value': 5});
    }
    // if (!_pickedExercisesIDs.contains(i)) {
    //   _pickedExercisesIDs.add(i);
    // pickedExercisesIDsAndCount.add();
    // }
    notifyListeners();
  }

  bool containIdInExercises(int id) {
    for (int i = 0; i < _pickedExercisesIDs.length; i++) {
      if (_pickedExercisesIDs[i]['id'] == id) {
        return true;
      }
    }
    return false;
  }

  void removeFromExercises(int i) {
    if (_pickedExercisesIDs.contains(i)) {
      _pickedExercisesIDs.removeWhere((element) => element == i);
    }
    notifyListeners();
  }

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

  // getExercisesData(String lang) async {
  //   try {
  //     ConvertedFutureExercisesList =
  //         await CreateWorkoutAPI().getExercisesList(lang);
  //     // futureExercisesList;
  //     // print(ConvertedFutureCategoriesList!.length);
  //     // if (ConvertedFutureCategoriesList != null) {
  //     for (var i = 0; i < ConvertedFutureExercisesList!.length; i++) {
  //       print(ConvertedFutureExercisesList![i].id.toString());
  //       // dropDownList?.add(ConvertedFutureCategoriesList![i].name.toString());
  //       // // dropDownList!.insert('v');
  //       // // print(dropDownList![i]);
  //       // print(ConvertedFutureCategoriesList![i].id.toString());
  //       // // dropDownList![i] = '$i';
  //       // print('dddddddddddd');
  //       // print(dropDownList![i]);
  //     }
  //     //   dropDownNewValue = ConvertedFutureCategoriesList![0].name.toString();
  //     // }
  //     // fetchedExercisesList = true;
  //     setfetchedExercisesList();
  //     notifyListeners();
  //     // return futureExercisesList;
  //   } catch (e) {
  //     print('get exercises in create workout error $e');
  //   }
  // }

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

  // setfetchedExercisesList() {
  //   fetchedExercisesList = true;
  //   notifyListeners();
  // }

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

  void changestateOfTime(int id) {
    for (int i = 0; i < _pickedExercisesIDs.length; i++) {
      if (_pickedExercisesIDs[i]['id'] == id) {
        _pickedExercisesIDs[i]['isTime'] = !_pickedExercisesIDs[i]['isTime'];
      }
    }
    notifyListeners();
  }

  changeSwitchState() {
    switchValue = !switchValue;
    // notifyListeners();
  }

  void decreaseCount(int id) {
    for (int i = 0; i < _pickedExercisesIDs.length; i++) {
      if (_pickedExercisesIDs[i]['id'] == id &&
          _pickedExercisesIDs[i]['value'] > 2) {
        _pickedExercisesIDs[i]['value']--;
      }
    }
    notifyListeners();
  }

  void increaseCount(int id) {
    for (int i = 0; i < _pickedExercisesIDs.length; i++) {
      if (_pickedExercisesIDs[i]['id'] == id) {
        _pickedExercisesIDs[i]['value']++;
      }
    }
    notifyListeners();
  }

  getCountVal(int id) {
    for (int i = 0; i < _pickedExercisesIDs.length; i++) {
      if (_pickedExercisesIDs[i]['id'] == id) {
        return _pickedExercisesIDs[i]['value'];
      }
    }
    notifyListeners();
  }

  // bool get getIsFetched => fetchedExercisesList;
  // List<CreateworkoutModel>? get exercisesList => ConvertedFutureExercisesList;

  List get getPickedExercises => _pickedExercisesIDs;
  bool get getIsLoading => _isLoading;
}
