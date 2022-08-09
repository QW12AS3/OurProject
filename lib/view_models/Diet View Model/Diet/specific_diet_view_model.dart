// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/models/diet_model.dart';
import 'package:provider/provider.dart';

import '../../../Api services/diet_api.dart';
import 'edit_diet_view_model.dart';

class SpecificDietViewModel with ChangeNotifier {
  bool _isLoading = false;
  DietModel _diet = DietModel();
  bool _isSubLoading = false;

  void setIsSubLoading(value) {
    _isSubLoading = value;
    notifyListeners();
  }

  void reset() {
    _diet = DietModel();
    _isLoading = false;
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> subscribeDiet(
      {required String lang,
      required int dietId,
      required BuildContext context}) async {
    setIsSubLoading(true);
    final response = await DietAPI().subscribeDiet(
      lang: lang,
      id: dietId,
    );
    if (response['success']) {
      _diet.subscribed = !_diet.subscribed;
      notifyListeners();
    } else {
      showSnackbar(Text(response['message']), context);
    }
    setIsSubLoading(false);
  }

  Future<void> setSpecDiet(
      {required String lang,
      required int id,
      required BuildContext context}) async {
    setIsLoading(true);
    _diet = await DietAPI().getSpeDiet(lang: lang, id: id);
    setIsLoading(false);

    Provider.of<EditDietViewModel>(context, listen: false)
        .initMealsList(getDiet.meals);
    notifyListeners();
  }

  bool get getIsLoading => _isLoading;
  DietModel get getDiet => _diet;
  bool get getIsSubLoading => _isSubLoading;
}
