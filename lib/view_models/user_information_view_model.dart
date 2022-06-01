import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';

class UserInformationViewModel with ChangeNotifier {
  var gender;
  DateTime birthdate = DateTime.now();
  bool dateIsSelected = false;
  Units weightUnit = Units.kg;
  Units heightUnit = Units.cm;

  Map<String, bool> diseases = {
    'Amyotrophic lateral sclerosis (ALS).': false,
    'Charcot-Marie-Tooth disease.': false,
    'Multiple sclerosis.': false,
    'Muscular dystrophy.': false,
    'Myasthenia gravis.': false,
    'Myopathy.': false,
    'Peripheral neuropathy.': false,
    'Peripheral neuropa1thy.': false,
    'Peripheral neuropa2thy.': false,
    'Peripheral neuropa3thy.': false,
  };

  bool checkHWValues(String h, String w, BuildContext context) {
    return true;
  }

  checkDetails1Value(GlobalKey<FormState> _formkey,
      PageController _pageController, BuildContext context) {
    if (gender == null) {
      showSnackbar(const Text('Please enter your gender'), context);
    } else if (!dateIsSelected) {
      showSnackbar(const Text('Please enter your birthdate'), context);
    } else if (_formkey.currentState != null) {
      if (_formkey.currentState!.validate()) {
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      }
    }
  }

  void changeDiseasesValue(key, changedValue) {
    diseases.update(key, (value) => changedValue);
    notifyListeners();
  }

  void changeGender(Gender selectedGender) {
    gender = selectedGender;
    notifyListeners();
  }

  void ChangeWeightUnit(Units unit) {
    weightUnit = unit;
    notifyListeners();
  }

  void ChangeHeightUnit(Units unit) {
    heightUnit = unit;
    notifyListeners();
  }

  changeBirthdate(BuildContext context) async {
    final selectedBirthdate = await showDatePicker(
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: orangeColor,
              onPrimary: Colors.white,
              onSurface: orangeColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: orangeColor,
              ),
            ),
          ),
          child: child!),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1922),
      lastDate: DateTime.now(),
    );
    if (selectedBirthdate != null) {
      birthdate = selectedBirthdate;
      dateIsSelected = true;
      notifyListeners();
    }
  }
}