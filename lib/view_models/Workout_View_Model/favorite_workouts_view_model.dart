import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/workout_list_api.dart';
import 'package:home_workout_app/models/workout_list_model.dart';

class favoriteWorkoutsViewModel with ChangeNotifier {
  List<WorkoutListModel>? workoutsList = [];
  int page = 1;
  bool isLoading = false;

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
  }

  getWorkoutsData(String lang, int page, String linkType) async {
    isLoading = true;
    setfutureworkoutsList(
        await WorkoutListsAPI().getworkouts(lang, '', '', page, linkType));
    increasePages();
    notifyListeners();
    // return futureworkoutsList;
  }

  deleteSpecificChallengeData(String lang, int? id) {
    WorkoutListsAPI().deleteExercise(lang, id);
    notifyListeners();
  }

  List<WorkoutListModel>? get getfutureworkoutsList => workoutsList;
}
