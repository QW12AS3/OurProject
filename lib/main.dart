import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/mobile_home_view_model.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/web_home_view_model.dart';
import 'package:home_workout_app/view_models/Sign%20in%20View%20Model/sign_in_view_model.dart';
import 'package:home_workout_app/view_models/edit_profile_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/Comments%20View/comments_view.dart';
import 'package:home_workout_app/views/Edit%20Profile%20View/edit_profile_view.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view.dart';
import 'package:home_workout_app/views/Home%20View/Web/web_home_view.dart';
import 'package:home_workout_app/views/User%20Information%20View/user_information_view.dart';
import 'package:home_workout_app/views/sign%20in%20view/sigin_view.dart';
import 'package:home_workout_app/views/start_view/start_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Vigor());
}

class Vigor extends StatelessWidget {
  Vigor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInformationViewModel()),
        ChangeNotifierProvider(create: (context) => MobileHomeViewModel()),
        ChangeNotifierProvider(create: (context) => WebHomeViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => signInViewModel()),
        ChangeNotifierProvider(create: (context) => EditProfileViewModel())
      ],
      child: MaterialApp(
          routes: {
            'comments': (context) => CommentsView(),
            'editProfile': (context) => EditProfileView(),
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
                  color: orangeColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
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
          home: UserInformationView()
          // StartView(),
          //const WebHomeView(),
          //home: LogIn(),
          //MobileHomeView(),
          //  UserInformationView(),
          ),
    );
  }
}
