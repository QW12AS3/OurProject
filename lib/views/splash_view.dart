import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (sharedPreferences.getBool('registered') == true &&
          sharedPreferences.getBool('info') == true) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (sharedPreferences.getBool('registered') == true &&
          sharedPreferences.getBool('info') != true) {
        Navigator.pushReplacementNamed(context, '/userinfo');
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orangeColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Image(
                width: 150,
                height: 150,
                image: const AssetImage("assets/images/Vigor logo.png"),
                //color: blueColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                  minHeight: 1, backgroundColor: orangeColor, color: blueColor),
            )
          ],
        ),
      ),
    );
  }
}
