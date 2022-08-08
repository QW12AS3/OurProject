import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/workout_list_api.dart';
import 'package:home_workout_app/models/workout_list_model.dart';

class WorkoutListViewModel with ChangeNotifier {
  Future<List<WorkoutListModel>>? futureworkoutsList;
  setfutureworkoutsList(Future<List<WorkoutListModel>>? futureworkoutsList) {
    futureworkoutsList = futureworkoutsList;
    notifyListeners();
  }

  getWorkoutsData(String lang, int page, String linkTupe) {
    futureworkoutsList = WorkoutListsAPI().getworkouts(lang, page, linkTupe);
    notifyListeners();
    return futureworkoutsList;
  }

  Future<List<WorkoutListModel>>? get getfutureworkoutsList =>
      futureworkoutsList;
}
