import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';

class UserInformationViewModel with ChangeNotifier {
  var gender;
  DateTime birthdate = DateTime.now();
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
      notifyListeners();
    }
  }
}
