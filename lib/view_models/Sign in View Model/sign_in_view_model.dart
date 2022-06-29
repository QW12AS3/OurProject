import 'package:flutter/widgets.dart';

class signInViewModel with ChangeNotifier {
  bool obscurePassword = true;
  changePasswordobscure() {
    obscurePassword = !obscurePassword;
    print(obscurePassword);
    notifyListeners();
  }
}
