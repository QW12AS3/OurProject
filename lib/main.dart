import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/login%20view/login_view.dart';
import 'package:provider/provider.dart';

import 'views/User Information View/user_information_view.dart';

void main() {
  runApp(const Vigor());
}

class Vigor extends StatelessWidget {
  const Vigor({Key? key}) : super(key: key);

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
          colorSchemeSeed: orangeColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                    fontFamily: 'JosefinSans',
                    color: orangeColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
                backgroundColor: MaterialStateProperty.all(orangeColor),
                elevation: MaterialStateProperty.all(2)),
          ),
          fontFamily: 'JosefinSans',
          textTheme: const TextTheme(
            // bodyLarge: TextStyle(
            //     color: orangeColor, fontSize: 30, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
                color: orangeColor, fontSize: 20, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(
                color: orangeColor, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        darkTheme: ThemeData(),
        home: LogIn(),
        //UserInformationView(),
      ),
    );
  }
}
