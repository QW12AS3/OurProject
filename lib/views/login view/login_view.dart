import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/views/login%20view/login_widgets.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    // color: Color.fromARGB(251, 133, 0, 78),
                    image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/login.jpg',
                  ),
                  colorFilter:
                      ColorFilter.mode(Colors.black54, BlendMode.darken),
                  //   color: Colors.black.withOpacity(0.001),
                  fit: BoxFit.fill,
                ))
                //  child: Image.asset(
                //               'assets/images/MainPageExercise.gif',
                //              // color: Colors.black.withOpacity(0.001),
                //               fit: BoxFit.fill,
                //             ),
                ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: mq.size.height * 0.07,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'Vigor',
                        style: TextStyle(
                            color: orangeColor,
                            fontSize: 55,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.size.height * 0.03,
                  ),
                  Container(
                    child: SvgPicture.asset(
                      'assets/images/vigorlogo.svg',
                      semanticsLabel: 'vigor Logo',
                      height: mq.size.height * 0.1,
                      width: mq.size.width * 0.15,
                      color: orangeColor,
                      // matchTextDirection: true,
                    ),
                  ),
                  // Container(
                  //   height: double.infinity,
                  //   // decoration: BoxDecoration(
                  //   //     // color: Color.fromARGB(251, 133, 0, 78),
                  //   //     image: const DecorationImage(
                  //   //   image: AssetImage(
                  //   //     'assets/images/login.jpg',
                  //   //   ),
                  //   //   // colorFilter:
                  //   //   //     ColorFilter.mode(Colors.black38, BlendMode.darken),
                  //   //   //   color: Colors.black.withOpacity(0.001),
                  //   //   //  fit: BoxFit.fill,
                  //   // ))
                  //   child: Image.asset(
                  //     'assets/images/muscle.jpg',
                  //     // color: Colors.black.withOpacity(0.001),
                  //     //   fit: BoxFit.fill,
                  //   ),
                  // ),

                  SizedBox(
                    height: mq.size.height * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      inputTextForm(
                        specialIcon: Icons.email_outlined,
                        textlabel: 'Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        secureText: false,
                      ),
                      SizedBox(
                        height: mq.size.height * 0.03,
                      ),
                      inputTextForm(
                        specialIcon: Icons.lock_outline_rounded,
                        textlabel: 'Password',
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        secureText: true,
                      ),
                      SizedBox(
                        height: mq.size.height * 0.01,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password',
                            style: theme.textTheme.bodySmall,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: mq.size.height * 0.05),
                      Container(
                        height: 40,
                        width: 110,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            // shape: StadiumBorder(),
                            side: BorderSide(width: 1, color: orangeColor),
                            elevation: 55,
                            backgroundColor: Colors.white.withOpacity(0.01),
                            //orangeColor.withOpacity(0.7),
                            primary: orangeColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: orangeColor,
                                //Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: mq.size.height * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Sign Up here',
                                style: theme.textTheme.bodySmall,
                              )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
