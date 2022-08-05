// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:home_workout_app/models/diet_model.dart';
import 'package:provider/provider.dart';

import '../../../Api services/diet_api.dart';
import 'edit_diet_view_model.dart';

class SpecificDietViewModel with ChangeNotifier {
  bool _isLoading = false;
  DietModel _diet = DietModel();

  void reset() {
    _diet = DietModel();
    _isLoading = false;
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> setSpecDiet(
      {required String lang,
      required int id,
      required BuildContext context}) async {
    setIsLoading(true);
    _diet = await DietAPI().getSpeDiet(lang: lang, id: id);
    setIsLoading(false);

    // _diet = DietModel();

    // _diet = DietModel.fromJsonForFull(
    //   {
    //     "name": "Keto Diet",
    //     "created_by": {
    //       "id": 8,
    //       "f_name": "Ammar",
    //       "l_name": "Hunaidi",
    //       "email": "ammar.hunaidi.01@gmail.com",
    //       "lang_country": null,
    //       "prof_img_url":
    //           "Default/RrmDmqreoLbR6dhjSVuFenDAii8uBWdqhi2fYSjK9pRISPykLSdefaultprofileimg.jpg",
    //       "gender": "male",
    //       "birth_date": "1990-05-05",
    //       "bio": "",
    //       "country": "Syria",
    //       "email_verified_at": "2022-07-07T02:13:02.000000Z",
    //       "deleted_at": null,
    //       "role_id": 3,
    //       "created_at": "2022-07-07T02:13:02.000000Z",
    //       "updated_at": "2022-07-07T02:13:02.000000Z"
    //     },
    //     "schedule": [
    //       {
    //         "day": 1,
    //         "meals": [
    //           {
    //             "id": 2,
    //             "type": "breakfast",
    //             "description": "Hello",
    //             "calorie_count": 80,
    //             "user_id": 8,
    //             "created_at": "2022-08-02T10:57:08.000000Z",
    //             "updated_at": "2022-08-02T10:57:08.000000Z"
    //           }
    //         ]
    //       },
    //       {
    //         "day": 2,
    //         "meals": [
    //           {
    //             "id": 3,
    //             "type": "lunch",
    //             "description": "How",
    //             "calorie_count": 100,
    //             "user_id": 8,
    //             "created_at": "2022-08-02T10:57:48.000000Z",
    //             "updated_at": "2022-08-02T10:57:48.000000Z"
    //           },
    //           {
    //             "id": 4,
    //             "type": "snack",
    //             "description": "are",
    //             "calorie_count": 50,
    //             "user_id": 8,
    //             "created_at": "2022-08-02T10:58:09.000000Z",
    //             "updated_at": "2022-08-02T10:58:09.000000Z"
    //           }
    //         ]
    //       },
    //       {
    //         "day": 3,
    //         "meals": [
    //           {
    //             "id": 4,
    //             "type": "snack",
    //             "description": "are",
    //             "calorie_count": 50,
    //             "user_id": 8,
    //             "created_at": "2022-08-02T10:58:09.000000Z",
    //             "updated_at": "2022-08-02T10:58:09.000000Z"
    //           }
    //         ]
    //       },
    //       {
    //         "day": 4,
    //         "meals": [
    //           {
    //             "id": 3,
    //             "type": "lunch",
    //             "description": "How",
    //             "calorie_count": 100,
    //             "user_id": 8,
    //             "created_at": "2022-08-02T10:57:48.000000Z",
    //             "updated_at": "2022-08-02T10:57:48.000000Z"
    //           },
    //           {
    //             "id": 5,
    //             "type": "dinner",
    //             "description": "you",
    //             "calorie_count": 180,
    //             "user_id": 8,
    //             "created_at": "2022-08-02T10:58:23.000000Z",
    //             "updated_at": "2022-08-02T10:58:23.000000Z"
    //           }
    //         ]
    //       },
    //       {
    //         "day": 5,
    //         "meals": [
    //           {
    //             "id": 2,
    //             "type": "breakfast",
    //             "description": "Hello",
    //             "calorie_count": 80,
    //             "user_id": 8,
    //             "created_at": "2022-08-02T10:57:08.000000Z",
    //             "updated_at": "2022-08-02T10:57:08.000000Z"
    //           }
    //         ]
    //       }
    //     ]
    //   },
    // );
    Provider.of<EditDietViewModel>(context, listen: false)
        .initMealsList(getDiet.meals);
    notifyListeners();
  }

  bool get getIsLoading => _isLoading;
  DietModel get getDiet => _diet;
}
