import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/general_challenges_api.dart';
import 'package:home_workout_app/models/challenge_model.dart';

class SpeceficChallengeViewModel with ChangeNotifier {
  ChallengeModel challenge = ChallengeModel();
  List<ChallengeModel> challengesList = [];
  // int page = 1;
  bool isLoading = true;
  setfuturechallenge(List<ChallengeModel>? futurechallengesList) {
    // challengesList = futurechallengesList;
    challengesList.addAll(futurechallengesList!);
    challenge = futurechallengesList[0];
    isLoading = false;
    print(challenge.img);
    notifyListeners();
  }

  // increasePages() {
  //   page++;
  //   notifyListeners();
  // }

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  reset() {
    challenge = ChallengeModel();
    // page = 1;
    isLoading = true;
    notifyListeners();
  }

  getData(String lang, int page, String linkType) async {
    isLoading = true;
    setfuturechallenge(
        await GeneralChallengesAPI().getUserchallenges(lang, page, linkType));
    isLoading = false;
    notifyListeners();
    // return futurechallengesList;
  }

  sendParticipate(String lang, int? id) async {
    return await GeneralChallengesAPI().participate(lang, id);
    notifyListeners();
  }

  getSpecificChallengeData(String lang, int? page, String linkType) {
    GeneralChallengesAPI().getUserchallenges(lang, page, linkType);
    notifyListeners();
  }

  deleteSpecificChallengeData(String lang, int? id) async {
    return await GeneralChallengesAPI().deleteChallenge(lang, id);
    notifyListeners();
  }

  ChallengeModel get getchallenge => challenge;
  bool get getisLoading => isLoading;
  List<ChallengeModel>? get getchallengesList => challengesList;
}
