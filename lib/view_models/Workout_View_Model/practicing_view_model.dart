import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/Api%20services/workout2_api.dart';

class PracticingViewModel with ChangeNotifier {
  int _currentExercise = 0;
  int _practiceId = 0;
  bool _isLoading = false;
  int _timer = 0;
  bool _isPlaying = false;

  void setIsPlaying(value) {
    _isPlaying = value;
    notifyListeners();
  }

  void reset() {
    _currentExercise = 0;
    _practiceId = 0;
    _isLoading = false;
    _isPlaying = false;
    _timer = 0;
  }

  void setTimer(int i) {
    _timer = i;
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> startPractice({required String lang, required int id}) async {
    setIsLoading(true);
    _practiceId = await Workout2Api().startPractice(lang: lang, id: id);
    setIsLoading(false);
    log(_practiceId.toString());
  }

  void setCurrentExerciseIndex(int i) {
    log(i.toString());
    _currentExercise = i;
    notifyListeners();
  }

  int get getCurrentExerciseIndex => _currentExercise;
  bool get getIsLoading => _isLoading;
  int get getTimer => _timer;
  bool get getIsPlaying => _isPlaying;
}
