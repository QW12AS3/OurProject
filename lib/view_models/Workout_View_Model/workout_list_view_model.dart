import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/workout_list_api.dart';
import 'package:home_workout_app/models/workout_list_model.dart';

class WorkoutListViewModel with ChangeNotifier {
  List<WorkoutListModel>? workoutsList = [];

  List<WorkoutListModel>? CategoriesList = [];
  String PickedCategoryValue = '';
  int CategoryNumber = 1;
  int page = 1;
  bool isLoading = false;
  bool CategoriesfetchedList = false;
  setfutureworkoutsList(List<WorkoutListModel>? futureworkoutsList) {
    workoutsList?.addAll(futureworkoutsList!);
    isLoading = false;
    print(futureworkoutsList);
    notifyListeners();
  }

  increasePages() {
    page++;
    notifyListeners();
  }

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  reset() {
    workoutsList = [];
    page = 1;
    isLoading = false;
    CategoriesfetchedList = false;
  }

  getWorkoutsData(String lang, int category, int difficulty, int page,
      String linkType) async {
    isLoading = true;
    setfutureworkoutsList(await WorkoutListsAPI()
        .getworkouts(lang, '/$category', '', page, linkType));
    increasePages();
    notifyListeners();
    // return futureworkoutsList;
  }

  getCategoriesData(String lang) async {
    try {
      CategoriesList = await WorkoutListsAPI().getCategoriesList(lang);
      // print(CategoriesList!.length);
      if (CategoriesList != null) {
        for (var i = 0; i < CategoriesList!.length; i++) {
          // dropDownList?.add(CategoriesList![i].name.toString());
          // dropDownList!.insert('v');
          // print(dropDownList![i]);
          print(CategoriesList![i].id.toString());
          // dropDownList![i] = '$i';
          print('dddddddddddd');
          // print(dropDownList![i]);
        }

        // dropDownNewValue = CategoriesList![0].name.toString();
        PickedCategoryValue = CategoriesList![0].name.toString();
        CategoriesfetchedList = true;
      }
      notifyListeners();
      // return futureworkoutList;
    } catch (e) {
      print('Categories fetch List error $e');
    }
  }

  updatePickedCategory(String pickedCategory) {
    PickedCategoryValue = pickedCategory;
    for (var i = 0; i < CategoriesList!.length; i++) {
      if (CategoriesList![i].name == pickedCategory) {
        CategoryNumber = CategoriesList![i].id!.toInt();
        print(CategoriesList![i].id.toString());
      }

      // dropDownList![i] = '$i';
      // print('dddddddddddd');
      // print(dropDownList![i]);
    }
    notifyListeners();
  }

  List<WorkoutListModel>? get getfutureworkoutsList => workoutsList;
  List<WorkoutListModel>? get getCategoriesList => CategoriesList;
}
