import 'package:flutter/cupertino.dart';

import '../Api services/sign_up_api.dart';

class HealthRecordViewModel with ChangeNotifier {
  bool _addDesc = false;
  String _searchVal = '';
  List _diseases = [];
  Future<void> setDiseases(String lang) async {
    final resp = await SignUpAPI().getDiseases(lang);

    resp.forEach(
      (element) {
        _diseases.add(
          {
            'id': element['id'],
            'name': element['name'],
            'selected': false,
          },
        );
      },
    );
    print(_diseases);
    notifyListeners();
  }

  void changeDiseasesValue(key, changedValue) {
    _diseases.firstWhere((element) => element['id'] == key)['selected'] =
        changedValue;
    notifyListeners();
  }

  void setSearchVal(String value) {
    _searchVal = value;
    notifyListeners();
  }

  void setAddDesc() {
    _addDesc = !_addDesc;
    notifyListeners();
  }

  bool get getAddDesc => _addDesc;
  String get getSearchVal => _searchVal;
  List get getDiseases => _diseases;
}
