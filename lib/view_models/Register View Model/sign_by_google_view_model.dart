import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_workout_app/Api%20services/sign_by_google_api.dart';
import 'package:home_workout_app/models/sign_by_google_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// remember to add provider to main
class SignByGoogleViewModel with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? _currentUser;
  String accessToken = '';
  userIsSignedIn() {
    // to make user signedin if the user signein before
    // maybe don't need it
    _googleSignIn.onCurrentUserChanged.listen((account) {
      _currentUser = account;
    });
    _googleSignIn.signInSilently();
    notifyListeners();
  }

  printDetails() {}
  void signOut() {
    _googleSignIn.disconnect();
  }

  // Future<void> signIn() async {
  //   try {
  //     _googleSignIn.signIn().then((result) {
  //       result?.authentication.then((googleKey) {
  //         accessToken = googleKey.accessToken.toString();

  //         print("ACCESS TOKEN:${googleKey.accessToken}");
  //         //   print(googleKey.idToken);
  //         print("Name: ${_googleSignIn.currentUser?.displayName}");
  //       }).catchError((err) {
  //         print('inner error');
  //         print(err);
  //       });
  //     }).catchError((err) {
  //       print('error occured');
  //       print(err);
  //     });
  //   } catch (e) {
  //     print('Google Sign in Error: $e');
  //   }

  //   if (accessToken != null && accessToken != '') {
  //     SignByGoogleViewModel().signOut();
  //     final BackEndMessage = postUserInfo(accessToken, '');
  //   }
  // }

  postUserInfo(String access_provider_tokenVal, String c_nameVal) async {
    SignByGoogleModel? result;
    print(access_provider_tokenVal);
    try {
      await SignByGoogleAPI.createUser(SignByGoogleModel(
        access_provider_token: access_provider_tokenVal,
        c_name: c_nameVal,
        m_token: '',
        mac: '',
        // message: '',
      )).then((value) {
        print(value);
        // print("toooooooooooooken:   " + value.access_token!);
        // print("messaaaaaaaaaaaaaage:${value.}")

        result = value;
      });
    } catch (e) {
      print(e);
    }

    if (result!.access_token != null && result!.refresh_token != null)
      setData(result!);
    return result;
  }

  setData(SignByGoogleModel Data) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    // _pref.setString("f_name", Data.f_name!);
    // _pref.setString("l_name", Data.l_name!);
    // _pref.setString("email", Data.email!);
    // _pref.setString("profile_img", Data.profile_img!);
    _pref.setString("access_token", Data.access_token!);
    _pref.setString("refresh_token", Data.refresh_token!);
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('Google Sign in Errooor: $e');
    }
  }
}





/*
Task :app:signingReport
Variant: debug
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------
Variant: release
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------
Variant: profile
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------
Variant: debugAndroidTest
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------

> Task :flutter_plugin_android_lifecycle:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------

> Task :google_sign_in_android:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------

> Task :image_picker_android:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------

> Task :shared_preferences_android:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------

> Task :video_player_android:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\FADI\.android\debug.keystore
Alias: AndroidDebugKey
MD5: EC:50:91:A5:94:B2:F8:40:D6:62:1F:E1:DE:BF:37:7E
SHA1: 91:CC:A3:B0:67:A3:6F:B9:20:28:BA:A8:D5:7E:2A:C5:D4:2C:B0:3B
SHA-256: D4:95:90:DF:05:4C:F7:D7:9D:D7:AA:C1:AE:9F:C6:23:2D:DD:7F:EC:23:5C:E3:49:EA:51:2E:58:3C:F9:14:53
Valid until: Sunday, March 17, 2052
----------

Deprecated Gradle features were used in this build, making it incompatible with Gradle 8.0.   

You can use '--warning-mode all' to show the individual deprecation warnings and determine if 
they come from your own scripts or plugins.

See https://docs.gradle.org/7.4/userguide/command_line_interface.html#sec:command_line_warnings

BUILD SUCCESSFUL in 29s
6 actionable tasks: 6 executed*/


/*
buildscript {
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository

  }
  dependencies {
    ...
    // Add this line
    classpath 'com.google.gms:google-services:4.3.13'

  }
}

allprojects {
  ...
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository

    ...
  }
}*/
/*
apply plugin: 'com.android.application'

// Add this line
apply plugin: 'com.google.gms.google-services'


dependencies {
  // Import the Firebase BoM
  implementation platform('com.google.firebase:firebase-bom:30.2.0')


  // Add the dependency for the Firebase SDK for Google Analytics
  // When using the BoM, don't specify versions in Firebase dependencies
  implementation 'com.google.firebase:firebase-analytics'


  // Add the dependencies for any other desired Firebase products
  // https://firebase.google.com/docs/android/setup#available-libraries
}*/

