import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/models/workout_model.dart';

class MobileHomeViewModel with ChangeNotifier {
  int _currentTab = 0;
  //temporary
  Map<String, bool> categories = {
    'Recommended': true,
    'All': false,
    'Arm': false,
    'Chest': false,
    'Back': false,
    'Leg': false,
  };

  //temporary
  List<Map<dynamic, dynamic>> workouts = [
    {
      'id': 1,
      'data': {
        'name': 'Arm',
        'categorie': 'Arm',
        'excersises': 7,
        'publisher': 'Ahmad',
        'excpectedTime': 50,
        'imageUrl':
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
      },
    },
    {
      'id': 5,
      'data': {
        'name': 'Arm',
        'categorie': 'Arm',
        'excersises': 7,
        'publisher': 'Ahmad',
        'excpectedTime': 50,
        'imageUrl':
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
      },
    },
    {
      'id': 2,
      'data': {
        'name': 'Arm',
        'categorie': 'Leg',
        'excersises': 7,
        'excpectedTime': 50,
        'publisher': 'Ahmad',
        'imageUrl':
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
      }
    },
    {
      'id': 3,
      'data': {
        'name': 'Arm',
        'categorie': 'All',
        'excersises': 7,
        'excpectedTime': 50,
        'publisher': 'Ahmad',
        'imageUrl':
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
      }
    },
    {
      'id': 4,
      'data': {
        'name': 'Arm',
        'categorie': 'Recommended',
        'excersises': 7,
        'excpectedTime': 50,
        'publisher': 'Ahmad',
        'imageUrl':
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
      }
    },
    {
      'id': 4,
      'data': {
        'name': 'Arm',
        'categorie': 'Recommended',
        'excersises': 7,
        'excpectedTime': 50,
        'publisher': 'Ahmad',
        'imageUrl':
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
      }
    },
    {
      'id': 4,
      'data': {
        'name': 'Arm',
        'categorie': 'Recommended',
        'excersises': 7,
        'excpectedTime': 50,
        'publisher': 'Ahmad',
        'imageUrl':
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
      }
    }
  ];

  void setCurrentTab(int i) {
    _currentTab = i;
    notifyListeners();
  }

  List<WorkoutModel> getWorkouts() {
    List<WorkoutModel> workoutsList = [];
    for (int i = 0; i < workouts.length; i++) {
      workoutsList.add(WorkoutModel.fromJson(workouts[i]));
    }
    return workoutsList;
  }

  changeSelectedCategorie(key, selectedValue) {
    categories.updateAll((key, value) => false);
    categories.update(key, (value) => selectedValue);
    notifyListeners();
  }

  int get getCurrentTab => _currentTab;
}
