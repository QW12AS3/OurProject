import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/mobile_home_view_model.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/web_home_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_by_google_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_in_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_up_view_model.dart';
import 'package:home_workout_app/view_models/another_user_profile_view_model.dart';
import 'package:home_workout_app/view_models/edit_profile_view_model.dart';
import 'package:home_workout_app/view_models/health_record_view_model.dart';
import 'package:home_workout_app/view_models/otp_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/Add%20Health%20Record%20View/add_health_record_view.dart';
import 'package:home_workout_app/views/Another%20User%20Profile%20View/another_user_profile_view.dart';
import 'package:home_workout_app/views/Change%20Email%20View/change_email_view.dart';
import 'package:home_workout_app/views/Change%20Password%20View/change_password_view.dart';
import 'package:home_workout_app/views/Comments%20View/comments_view.dart';
import 'package:home_workout_app/views/Edit%20Profile%20View/edit_profile_view.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view.dart';
import 'package:home_workout_app/views/User%20Information%20View/user_information_view.dart';
import 'package:home_workout_app/views/otp_view.dart';
import 'package:home_workout_app/views/sign%20in%20view/sigin_view.dart';
import 'package:home_workout_app/views/sign%20up%20view/sign_up_view.dart';

import 'package:home_workout_app/views/start_view/start_view.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool('provider', true);
  print(sharedPreferences.getBool('provider'));

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('ar'),
      child: const Vigor(),
    ),
  );
}

class Vigor extends StatelessWidget {
  const Vigor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //context.setLocale(Locale('en'));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInformationViewModel()),
        ChangeNotifierProvider(create: (context) => MobileHomeViewModel()),
        ChangeNotifierProvider(create: (context) => WebHomeViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => signInViewModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => EditProfileViewModel()),
        ChangeNotifierProvider(create: (context) => SignByGoogleViewModel()),
        ChangeNotifierProvider(
          create: (context) => AnotherUserProfileViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => otpViewModel()),
        ChangeNotifierProvider(create: (context) => HealthRecordViewModel())
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        // onGenerateRoute: (settings) {
        //   switch (settings.name) {
        //     case 'comments':
        //       return PageTransition(
        //           child: CommentsView(),
        //           type: PageTransitionType.leftToRight);
        //     case 'editProfile':
        //       return PageTransition(
        //           child: EditProfileView(), type: PageTransitionType.scale);
        //     case 'changeEmail':
        //       return PageTransition(
        //           child: ChangeEmailView(),
        //           type: PageTransitionType.leftToRight);
        //     default:
        //       return null;
        //   }
        // },
        initialRoute: '/userinfo',
        routes: {
          '/signup': (context) => SignUp(),
          '/signin': (context) => SignIn(),
          // '/': (context) => StartView(),
          '/otp': (context) => OTPView(),
          'comments': (context) => CommentsView(),
          'editProfile': (context) => EditProfileView(),
          'changeEmail': (context) => ChangeEmailView(),
          'changePassword': (context) => ChangePasswordView(),
          'anotherUserProfile': (context) => AnotherUserProfileView(),
          '/home': (context) => MobileHomeView(),
          '/userinfo': (context) => UserInformationView(),
          '/addHealthRecord': (context) => AddHealthRecordView()
        },
        title: 'Vigor',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorSchemeSeed: orangeColor,
          tabBarTheme: TabBarTheme(
            labelColor: orangeColor,
            unselectedLabelColor: greyColor,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: orangeColor)),
          snackBarTheme: SnackBarThemeData(
            contentTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
            backgroundColor: orangeColor.withOpacity(0.9),
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: blueColor)),
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(blueColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: orangeColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                    fontFamily: 'JosefinSans',
                    color: orangeColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
                backgroundColor: MaterialStateProperty.all(orangeColor),
                elevation: MaterialStateProperty.all(2)),
          ),
          fontFamily: 'JosefinSans',
          textTheme: TextTheme(
            displaySmall: const TextStyle(
                fontFamily: 'JosefinSans',
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500),
            bodyLarge: TextStyle(
                color: orangeColor, fontSize: 30, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
                fontFamily: 'JosefinSans',
                color: orangeColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            bodySmall: TextStyle(
                fontFamily: 'JosefinSans',
                color: orangeColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        darkTheme: ThemeData(),

        //home: kIsWeb ? const WebHomeView() : const MobileHomeView(),
        // home: UserInformationView()

        // StartView(),
        //  home: UserInformationView(),

        //home: SignUp(),

        //home: SignUp(),

        // home: StartView(),
        //  home: const MobileHomeView(),

        // home: SignIn(),
        // home: OTPView(),
        // home: SignUp(),
//         home: MobileHomeView(),
        //  UserInformationView(),
      ),
    );
  }
}
