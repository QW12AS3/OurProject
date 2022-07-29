import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/CV%20View%20Model/edit_apply_view_model.dart';
import 'package:home_workout_app/view_models/Dashboards%20View%20Model/dashboards_view_model.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/mobile_home_view_model.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/web_home_view_model.dart';
import 'package:home_workout_app/view_models/Posts%20View%20Model/create_post_view_model.dart';
import 'package:home_workout_app/view_models/Posts%20View%20Model/edit_post_view_model.dart';
import 'package:home_workout_app/view_models/Posts%20View%20Model/posts_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_by_google_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_in_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_up_view_model.dart';
import 'package:home_workout_app/view_models/another_user_profile_view_model.dart';
import 'package:home_workout_app/view_models/CV%20View%20Model/apply_view_model.dart';
import 'package:home_workout_app/view_models/comments_view_model.dart';
import 'package:home_workout_app/view_models/create_challenge_view_model.dart';
import 'package:home_workout_app/view_models/edit_profile_view_model.dart';
import 'package:home_workout_app/view_models/forget_password_view_model.dart';
import 'package:home_workout_app/view_models/general_challenges_view_model.dart';
import 'package:home_workout_app/view_models/health_record_view_model.dart';
import 'package:home_workout_app/view_models/otp_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/view_models/reset_password_view_model.dart';
import 'package:home_workout_app/view_models/Posts%20View%20Model/saved_posts_view_model.dart';
import 'package:home_workout_app/view_models/start_view_model.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/Add%20Health%20Record%20View/add_health_record_view.dart';
import 'package:home_workout_app/views/Another%20User%20Profile%20View/another_user_profile_view.dart';
import 'package:home_workout_app/views/Apply%20CV%20View/apply_view.dart';
import 'package:home_workout_app/views/Apply%20CV%20View/cv_view.dart';
import 'package:home_workout_app/views/Apply%20CV%20View/edit_apply_view.dart';
import 'package:home_workout_app/views/Apply%20CV%20View/pdf_view.dart';

import 'package:home_workout_app/views/Change%20Email%20View/change_email_view.dart';
import 'package:home_workout_app/views/Change%20Password%20View/change_password_view.dart';
import 'package:home_workout_app/views/Comments%20View/comments_view.dart';
import 'package:home_workout_app/views/Dashboards%20View/cvs_dashbaord.dart';
import 'package:home_workout_app/views/Dashboards%20View/dashboard_view.dart';
import 'package:home_workout_app/views/Dashboards%20View/posts_dashboard_view.dart';
import 'package:home_workout_app/views/Dashboards%20View/reported_comments_dashbaord.dart';
import 'package:home_workout_app/views/Dashboards%20View/reported_post_dashboard_view.dart';
import 'package:home_workout_app/views/Edit%20Health%20Record%20View/edit_health_record_view.dart';
import 'package:home_workout_app/views/Edit%20Profile%20View/edit_profile_view.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view.dart';
import 'package:home_workout_app/views/Posts%20View/create_post_view.dart';
import 'package:home_workout_app/views/Posts%20View/edit_post_view.dart';
import 'package:home_workout_app/views/Posts%20View/post_view.dart';
import 'package:home_workout_app/views/User%20Information%20View/user_information_view.dart';
import 'package:home_workout_app/views/challenges/create_challenge_view.dart';
import 'package:home_workout_app/views/challenges/general_challenges_view.dart';
import 'package:home_workout_app/views/forget_password_view.dart';
import 'package:home_workout_app/views/ip_view.dart';
import 'package:home_workout_app/views/otp_view.dart';
import 'package:home_workout_app/views/reset_password_view.dart';
import 'package:home_workout_app/views/saved_posts_view.dart';
import 'package:home_workout_app/views/sign%20in%20view/sigin_view.dart';
import 'package:home_workout_app/views/sign%20up%20view/sign_up_view.dart';
import 'package:home_workout_app/views/splash_view.dart';

import 'package:home_workout_app/views/start_view/start_view.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool('provider', true);
  print(sharedPreferences.getBool('provider'));

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child: const Vigor(),
    ),
  );
}

class Vigor extends StatelessWidget {
  const Vigor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.setLocale(const Locale('en'));
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
            create: (context) => AnotherUserProfileViewModel()),
        ChangeNotifierProvider(create: (context) => otpViewModel()),
        ChangeNotifierProvider(create: (context) => HealthRecordViewModel()),
        ChangeNotifierProvider(create: (context) => CreatePostViewModel()),
        ChangeNotifierProvider(create: (context) => ForgetPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => ResetPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => PostsViewModel()),
        ChangeNotifierProvider(create: (context) => CommentsViewModel()),
        ChangeNotifierProvider(create: (context) => SavedPostsViewModel()),
        ChangeNotifierProvider(create: (context) => EditPostViewModel()),
        ChangeNotifierProvider(create: (context) => ApplyViewModel()),
        ChangeNotifierProvider(create: (context) => EditApplyViewModel()),
        ChangeNotifierProvider(create: (context) => StartViewModel()),
        ChangeNotifierProvider(
            create: (context) => GeneralChallengesViewModel()),
        ChangeNotifierProvider(
            create: (context) => CreateChallengesViewModel()),
        ChangeNotifierProvider(create: (context) => DashboardsViewModel()),

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

        initialRoute: '/splash',
        routes: {
          '/signup': (context) => SignUp(),
          '/signin': (context) => SignIn(),
          '/start': (context) => StartView(),
          '/otp': (context) => OTPView(),
          '/comments': (context) => CommentsView(),
          '/editProfile': (context) => EditProfileView(),
          '/changeEmail': (context) => ChangeEmailView(),
          '/changePassword': (context) => ChangePasswordView(),
          '/anotherUserProfile': (context) => AnotherUserProfileView(),
          '/home': (context) => MobileHomeView(),
          '/userinfo': (context) => UserInformationView(),
          '/addHealthRecord': (context) => AddHealthRecordView(),
          '/splash': (context) => SplashView(),
          '/editHealthRecord': (context) => EditHealthRecordView(),
          '/createPost': (context) => CreatePostView(),
          '/forgetPassword': (context) => ForgetPasswordView(),
          '/resetPassword': (context) => ResetPasswordView(),
          '/postView': (context) => PostView(),
          '/savedPosts': (context) => SavedPostsView(),
          '/editPostView': (context) => EditPostView(),
          '/challenges': (context) => GeneralChallengesView(),
          '/createChallenge': (context) => CreateChallengeView(),
          // '/': (context) => IPView()
          '/apply': (context) => ApplyView(),
          '/pdf': (context) => PDFView(),
          '/cv': (context) => CVView(),
          '/editCV': (context) => EditApplyView(),
          '/dashboard': (context) => DashboardsView(),
          '/postsDashboard': (context) => PostsDashbaordView(),
          '/cvsDashboard': (context) => CVsDashboard(),
          '/reportedPostDashboard': (context) => ReportedPostsDashbaordView(),
          '/reportedCommentsDashboard': (context) => ReportedCommentsDashboard()
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: orangeColor)),
          snackBarTheme: SnackBarThemeData(
            contentTextStyle: Theme.of(context).textTheme.bodyMedium!,
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
