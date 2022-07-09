// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/Api%20services/profile_api.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileViewModel with ChangeNotifier {
  XFile _userImage = XFile('');
  Gender _gender = Gender.male;
  DateTime _birthdate = DateTime.now();
  String _bio = '';
  String _country = '';
  Units _weightUnit = Units.kg;
  Units _heightUnit = Units.cm;

  bool _emailpasswordObsecure = true;

  bool _passwordObsecure1 = true;
  bool _passwordObsecure2 = true;
  bool _passwordObsecure3 = true;

  bool _isLoading = false;

  void ChangeWeightUnit(Units unit) {
    _weightUnit = unit;
    notifyListeners();
  }

  void ChangeHeightUnit(Units unit) {
    _heightUnit = unit;
    notifyListeners();
  }

  void setemailPasswordObsecure() {
    _emailpasswordObsecure = !_emailpasswordObsecure;
    notifyListeners();
  }

  void setPasswordObsecure1() {
    _passwordObsecure1 = !_passwordObsecure1;
    notifyListeners();
  }

  void setPasswordObsecure2() {
    _passwordObsecure2 = !_passwordObsecure2;
    notifyListeners();
  }

  void setPasswordObsecure3() {
    _passwordObsecure3 = !_passwordObsecure3;
    notifyListeners();
  }

  void setGender(Gender newGender) {
    _gender = newGender;
    notifyListeners();
  }

  void setInitialData(BuildContext ctx) {
    _gender =
        Provider.of<ProfileViewModel>(ctx, listen: false).getUserData.gender;
    _birthdate =
        Provider.of<ProfileViewModel>(ctx, listen: false).getUserData.birthdate;
    _bio = Provider.of<ProfileViewModel>(ctx, listen: false).getUserData.bio;
    _country = Provider.of<ProfileViewModel>(ctx, listen: false)
        .getUserData
        .countryName;
  }

  Future<void> changePhoto(ImageSource src) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: src);
    if (pickedImage != null) {
      _userImage = pickedImage;
    }
    notifyListeners();
  }

  void resetUserImage() {
    _userImage = XFile('');
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
      _birthdate = selectedBirthdate;
      notifyListeners();
    }
  }

  void changeCountry(newCountry) {
    _country = newCountry;
    notifyListeners();
  }

  Future<void> changeEmail(
      String oldEmail, String newEmail, String password) async {
    bool response =
        await ProfileApi().changeEmail(oldEmail, newEmail, password);
    if (response) {
      //Navigate to confirmation page

    } else {
      //drop
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword,
      String confirmPassword, BuildContext context) async {
    bool response = await ProfileApi()
        .changePassword(oldPassword, newPassword, confirmPassword);
    if (response) {
      Navigator.pop(context);
    } else {
      showSnackbar(const Text('Change password failed'), context);
    }
  }

  Future<void> editProfile(
      String fname,
      String lname,
      XFile image,
      String bio,
      String height,
      String weight,
      Gender gender,
      DateTime birthdate,
      BuildContext context,
      String country) async {
    _isLoading = true;
    final response = await ProfileApi().editProfile(fname, lname, image, bio,
        height, weight, gender, birthdate, country, context);
    _isLoading = false;
    if (response['success']) {
      showSnackbar(Text(response['message']), context);
      Navigator.pop(context);
    } else {
      showSnackbar(Text(response['message']), context);
    }
    notifyListeners();
  }

  XFile get getUserImage => _userImage;
  Gender get getGender => _gender;
  DateTime get getBirthdate => _birthdate;
  String get getBio => _bio;
  String get getCountry => _country;
  bool get getPasswordObsecure1 => _passwordObsecure1;
  bool get getPasswordObsecure2 => _passwordObsecure2;
  bool get getPasswordObsecure3 => _passwordObsecure3;

  bool get getemailPasswordObsecure => _emailpasswordObsecure;

  Units get getWeight => _weightUnit;
  Units get getHeight => _heightUnit;
  bool get getIsLoading => _isLoading;
}
