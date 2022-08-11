import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class SettingsViewModel with ChangeNotifier {
  bool _isEnglish = true;

  void setLang(value, BuildContext context) {
    _isEnglish = value;

    context.setLocale(Locale(value ? 'en' : 'ar'));
    notifyListeners();
  }

  bool get getLang => _isEnglish;
}
