import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_by_google_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_by_google_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_in_view_model.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:home_workout_app/views/otp_view.dart';

import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController c_nameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton.extended(
        //     // focusColor: orangeColor,
        //     // hoverColor: orangeColor,
        //     // splashColor: orangeColor,
        //     elevation: 0,
        //     icon: Icon(
        //       Icons.skip_next,
        //       color: blueColor,
        //     ),
        //     onPressed: () {}, //TODO:
        //     backgroundColor: Colors.white.withOpacity(0),
        //     label: Text(
        //       'Skip',
        //       style: TextStyle(
        //         color: blueColor,
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     )),
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/login.jpg',
                  ),
                  colorFilter:
                      ColorFilter.mode(Colors.black54, BlendMode.darken),
                  //   color: Colors.black.withOpacity(0.001),
                  fit: BoxFit.cover,
                ))),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: mq.size.height * 0.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white70.withOpacity(0.3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: mq.size.height * 0.02,
                            ),
                            Form(
                              key: formGlobalKey,
                              child: Column(
                                children: [
                                  Container(
                                    height: 0,
                                    width: 0,
                                    child: TextFormField(
                                      controller: c_nameController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(5),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 380,
                                    decoration: BoxDecoration(
                                        color: Colors.white70.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: TextFormField(
                                      // maxLength: 25,
                                      controller: emailController,
                                      validator: (value) {
                                        return signInViewModel()
                                            .checkEmail(value.toString());
                                      },
                                      decoration: InputDecoration(
                                        // focusedErrorBorder:  OutlineInputBorder(
                                        //   borderSide:
                                        //       BorderSide(color: blueColor, width: 1.5),
                                        //   borderRadius: BorderRadius.all(
                                        //     Radius.circular(15),
                                        //   ),
                                        // ),

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: greyColor, width: 1.5),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.5),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: orangeColor, width: 1.5),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                            color: orangeColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: blueColor,
                                          size: 33,
                                        ),
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.emailAddress,

                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.03,
                                  ),
                                  Container(
                                      width: 380,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.white70.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Consumer<signInViewModel>(
                                          builder: ((context, value, _) =>
                                              TextFormField(
                                                controller: passwordController,
                                                validator: (value) {
                                                  return signInViewModel()
                                                      .checkPassword(
                                                          value.toString());
                                                },
                                                decoration: InputDecoration(
                                                    // focusedErrorBorder:  OutlineInputBorder(
                                                    //   borderSide:
                                                    //       BorderSide(color: blueColor, width: 1.5),
                                                    //   borderRadius: BorderRadius.all(
                                                    //     Radius.circular(15),
                                                    //   ),
                                                    // ),

                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: greyColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: orangeColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                    labelText: 'Password',
                                                    labelStyle: TextStyle(
                                                        color: orangeColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    prefixIcon: Icon(
                                                      Icons
                                                          .lock_outline_rounded,
                                                      color: blueColor,
                                                      size: 33,
                                                    ),
                                                    suffixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Provider.of<signInViewModel>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changePasswordobscure();
                                                          },
                                                          icon: Icon(
                                                            Provider.of<signInViewModel>(
                                                                        context)
                                                                    .obscurePassword
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color: blueColor,
                                                            size: 33,
                                                          )),
                                                    )),
                                                style: TextStyle(
                                                    color: blueColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                obscureText: Provider.of<
                                                            signInViewModel>(
                                                        context)
                                                    .obscurePassword,
                                                textInputAction:
                                                    TextInputAction.done,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      50),
                                                ],
                                              )))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: mq.size.height * 0.01,
                            ),
                            TextButton(
                                //TODO:
                                onPressed: () {},
                                child: Text(
                                  'Forgot password ?',
                                  style: theme.textTheme.bodySmall,
                                ))
                          ],
                        ),
                      ),
                    ),
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
                            // elevation: 55,
                            backgroundColor: Colors.white.withOpacity(0.01),
                            //orangeColor.withOpacity(0.7),
                            primary: orangeColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: () async {
                            if (formGlobalKey.currentState!.validate()) {
                              formGlobalKey.currentState!.save();
                              // use the email provided here

                              final SignInModel BackEndMessage =
                                  await signInViewModel().postUserInfo(
                                      //TODO:
                                      emailController.text,
                                      passwordController.text,
                                      '',
                                      '',
                                      c_nameController.text);
                              print(BackEndMessage);
                              print(BackEndMessage.refresh_token);
                              final sBar = SnackBar(
                                  // margin: EdgeInsets.all(8.0),
                                  padding: EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(33)),
                                  content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(BackEndMessage.message ?? '')));
                              if (BackEndMessage.message != null &&
                                  BackEndMessage.message != '') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(sBar);
                              }
                              if (BackEndMessage.statusCode == 201 ||
                                  BackEndMessage.statusCode == 450 ||
                                  BackEndMessage.statusCode == 250) {
                                emailController.clear();
                                passwordController.clear();
                                c_nameController.clear();
                                try {
                                  if (BackEndMessage.statusCode == 201 &&
                                      BackEndMessage.is_verified == true) {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/userinfo');
                                  } else {
                                    Navigator.of(context).pushReplacementNamed(
                                        '/otp',
                                        arguments: {
                                          'state': (BackEndMessage.statusCode ==
                                                      201 ||
                                                  BackEndMessage.statusCode ==
                                                      450)
                                              ? 'sign 201'
                                              : 'sign 250'
                                        });
                                  }
                                } catch (e) {
                                  print('navigate to otp error: $e');
                                }
                              }
                            }
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                color: orangeColor,
                                //Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: mq.size.height * 0.05),
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
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                  '/signup',
                                );
                              },
                              child: Text(
                                'Sign up here',
                                style: theme.textTheme.bodySmall,
                              )),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            height: 20,
                            thickness: 5,
                            // indent: 20,
                            // endIndent: 0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('or'),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            height: 20,
                            thickness: 5,
                            // indent: 20,
                            // endIndent: 0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mq.size.height * 0.05),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: mq.size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<SignByGoogleViewModel>(
                            builder: ((context, value, _) => IconButton(
                                onPressed: () async {
                                  final SignByGoogleModel? BackEndMessage =
                                      await SignByGoogleViewModel().signIn();
                                  print('vvvvvvvvvvvvvvvvvvvvvvvvvvvv');
                                  print(BackEndMessage!.refresh_token);

                                  // SignByGoogleViewModel().signIn();

                                  //    final String googleAccessToken = value.;
                                  //    await SignByGoogleViewModel().signIn();
                                  // String googleAccessToken =
                                  //     Provider.of<SignByGoogleViewModel>(context,
                                  //             listen: false)
                                  //         .accessToken;

                                  // print(
                                  //     'googleAccessToken: ${value.BackEndMessage.message}');
                                  // if (value.BackEndMessage. != null &&
                                  //     googleAccessToken != '') {
                                  //   final SignByGoogleModel BackEndMessage =
                                  //       await SignByGoogleViewModel().postUserInfo(
                                  //           googleAccessToken,
                                  //           '',
                                  //           '',
                                  //           c_nameController.text);

                                  // final sBar = SnackBar(
                                  //     // margin: EdgeInsets.all(8.0),
                                  //     padding: EdgeInsets.all(8.0),
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius:
                                  //             BorderRadius.circular(33)),
                                  //     content: Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Text(
                                  //             value.BackEndMessage.message ??
                                  //                 '')));
                                  // if (value.BackEndMessage.message != null &&
                                  //     value.BackEndMessage.message != '') {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(sBar);
                                  // }
                                  // if (value.BackEndMessage.statusCode == 201 ||
                                  //     value.BackEndMessage.statusCode == 450) {
                                  //   if (c_nameController != null) {
                                  //     c_nameController.clear();
                                  //   }
                                  //   try {
                                  //     Navigator.of(context)
                                  //         .pushReplacementNamed(
                                  //       '/otp',
                                  //     );
                                  //   } catch (e) {
                                  //     print('navigate to otp error: $e');
                                  //   }
                                  // }
                                },
                                // },
                                icon:
                                    Image.asset('assets/images/google.png')))),
                        IconButton(
                          onPressed: () {
                            //TODO:
                            DateTime dateTime = DateTime.now();
                            print(dateTime.timeZoneName);
                            print(dateTime.timeZoneOffset);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => OTPView()));
                          },
                          icon: Image.asset(
                            'assets/images/facebook.png',
                          ),
                          //   iconSize: mq.size.width * 0.01,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {}, //TODO:
                            child: Text(
                              ' Skip > ',
                              style: theme.textTheme.bodySmall,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
