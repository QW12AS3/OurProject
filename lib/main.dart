import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/login%20view/login_view.dart';
import 'package:provider/provider.dart';

import 'views/User Information View/user_information_view.dart';

void main() {
  runApp(Vigor());
}

class Vigor extends StatelessWidget {
  Vigor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInformationViewModel())
      ],
      child: MaterialApp(
        title: 'Vigor',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
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
          colorSchemeSeed: orangeColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: orangeColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
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
            // bodyLarge: TextStyle(
            //     color: orangeColor, fontSize: 30, fontWeight: FontWeight.bold),
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
        home: UserInformationView(),
        //UserInformationView(),
      ),
    );
  }
}
