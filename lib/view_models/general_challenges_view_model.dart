import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/general_challenges_api.dart';
import 'package:home_workout_app/models/challenge_model.dart';

class GeneralChallengesViewModel with ChangeNotifier {
  Future<List<ChallengeModel>>? futurechallengesList;
  setfuturechallengesList(Future<List<ChallengeModel>>? futurechallengesList) {
    futurechallengesList = futurechallengesList;
    notifyListeners();
  }

  getData(String lang, int page, String linkTupe) {
    futurechallengesList =
        GeneralChallengesAPI().getUserchallenges(lang, page, linkTupe);
    notifyListeners();
    return futurechallengesList;
  }

  sendParticipate(String lang, int? id) {
    GeneralChallengesAPI().participate(lang, id);
    notifyListeners();
  }

  getSpecificChallengeData(String lang, int? page, String linkTupe) {
    GeneralChallengesAPI().getUserchallenges(lang, page, linkTupe);
    notifyListeners();
  }

  deleteSpecificChallengeData(String lang, int? id) {
    GeneralChallengesAPI().deleteChallenge(lang, id);
    notifyListeners();
  }
}
