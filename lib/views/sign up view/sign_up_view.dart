import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/sign_up_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_by_google_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_in_view_model.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_up_view_model.dart';
import 'package:home_workout_app/views/otp_view.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confimPasswordController = TextEditingController();
  TextEditingController c_nameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: Container(
        //   color: Colors.white.withOpacity(0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     // mainAxisSize: MainAxisSize.min,
        //     children: [
        //       ElevatedButton.icon(
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.skip_next,
        //           color: blueColor,
        //         ),
        //         label: Text(
        //           'Skip',
        //           style: TextStyle(
        //             color: blueColor,
        //             fontSize: 20,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
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
        //     backgroundColor: Colors.white.withOpacity(0.3),
        //     label: Text(
        //       'Skip',
        //       style: TextStyle(
        //         color: blueColor,
        //         fontSize: 17,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     )),
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
                  fit: BoxFit.cover,
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
                    height: mq.size.height * 0.1,
                  ),
                  Container(
                    width: 420,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.white70.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: TextFormField(
                                        controller: firstNameController,
                                        validator: (value) {
                                          return SignUpViewModel()
                                              .checkFirstName(value.toString());
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: greyColor, width: 1.5),
                                            borderRadius:
                                                const BorderRadius.all(
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
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          labelText: 'First name',
                                          labelStyle: TextStyle(
                                              color: orangeColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          prefixIcon: Icon(
                                            CupertinoIcons.profile_circled,
                                            color: blueColor,
                                            size: 33,
                                          ),
                                        ),
                                        style: TextStyle(
                                            color: blueColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.white70.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: TextFormField(
                                        controller: lastNameController,
                                        validator: (value) {
                                          return SignUpViewModel()
                                              .checkLastName(value.toString());
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: greyColor, width: 1.5),
                                            borderRadius:
                                                const BorderRadius.all(
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
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          labelText: 'Last name',
                                          labelStyle: TextStyle(
                                              color: orangeColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          prefixIcon: Icon(
                                            CupertinoIcons.profile_circled,
                                            color: blueColor,
                                            size: 33,
                                          ),
                                        ),
                                        style: TextStyle(
                                            color: blueColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                      color: Colors.white70.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      return SignUpViewModel()
                                          .checkEmail(value.toString());
                                    },
                                    decoration: InputDecoration(
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
                                    style: TextStyle(
                                        color: blueColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Colors.white70.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Consumer<SignUpViewModel>(
                                        builder: ((context, value, _) =>
                                            TextFormField(
                                              controller: passwordController,
                                              validator: (value) {
                                                return SignUpViewModel()
                                                    .checkPassword(
                                                        value.toString());
                                              },
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: greyColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
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
                                                        const BorderRadius.all(
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
                                                    Icons.lock_outline_rounded,
                                                    color: blueColor,
                                                    size: 33,
                                                  ),
                                                  suffixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Provider.of<SignUpViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .changePasswordobscure();
                                                        },
                                                        icon: Icon(
                                                          Provider.of<SignUpViewModel>(
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
                                                  fontWeight: FontWeight.bold),
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText:
                                                  Provider.of<SignUpViewModel>(
                                                          context)
                                                      .obscurePassword,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onEditingComplete: () {
                                                // Move the focus to the next node explicitly.
                                                FocusScope.of(context)
                                                    .nextFocus();
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              },
                                            )))),
                                SizedBox(
                                  height: mq.size.height * 0.02,
                                ),
                                Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Colors.white70.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Consumer<SignUpViewModel>(
                                        builder: ((context, value, _) =>
                                            TextFormField(
                                              controller:
                                                  confimPasswordController,
                                              validator: (value) {
                                                return SignUpViewModel()
                                                    .checkConfirmPassword(
                                                        value.toString(),
                                                        passwordController
                                                            .text);
                                              },
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: greyColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
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
                                                        const BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                  labelText: 'Confirm password',
                                                  labelStyle: TextStyle(
                                                      color: orangeColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  prefixIcon: Icon(
                                                    Icons.lock_outline_rounded,
                                                    color: blueColor,
                                                    size: 33,
                                                  ),
                                                  suffixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Provider.of<SignUpViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .changeConfirmPasswordobscure();
                                                        },
                                                        icon: Icon(
                                                          Provider.of<SignUpViewModel>(
                                                                      context)
                                                                  .obscureConfirmPassword
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
                                                  fontWeight: FontWeight.bold),
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText:
                                                  Provider.of<SignUpViewModel>(
                                                          context)
                                                      .obscureConfirmPassword,
                                              textInputAction:
                                                  TextInputAction.done,
                                            )))),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: mq.size.height * 0.01,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot password ?',
                                style: theme.textTheme.bodySmall,
                              ))
                        ],
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

                              final SignUpModel BackEndMessage =
                                  await SignUpViewModel().postUserInfo(
                                      firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      confimPasswordController.text,
                                      '',
                                      '',
                                      c_nameController.text);
                              print(BackEndMessage);
                              final sBar = SnackBar(
                                  // margin: EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.all(8.0),
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
                              print("ffffffffffffxsxxxxxxxxxxxxxxxxx");
                              print(BackEndMessage.statusCode);
                              if (BackEndMessage.statusCode == 201 ||
                                  BackEndMessage.statusCode == 450) {
                                Navigator.of(context).pushReplacementNamed(
                                  '/otp',
                                );
                                firstNameController.clear();
                                lastNameController.clear();
                                emailController.clear();
                                passwordController.clear();
                                confimPasswordController.clear();
                                if (c_nameController != null)
                                  c_nameController.clear();
                              }
                            }
                          },
                          child: Text(
                            'Sign up',
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
                                  '/signin',
                                );
                              },
                              child: Text(
                                'Sign in here',
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
                  SizedBox(height: mq.size.height * 0.03),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: mq.size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              try {
                                Provider.of<SignByGoogleViewModel>(context,
                                        listen: false)
                                    .signIn();
                              } catch (e) {
                                print('sign by google erroooor: $e');
                              }
                            },
                            icon: Image.asset('assets/images/google.png')),
                        IconButton(
                          onPressed: () {},
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
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         // OutlinedButton(
            //         //   style: OutlinedButton.styleFrom(
            //         //     // shape: StadiumBorder(),
            //         //     side: BorderSide(width: 1, color: orangeColor),
            //         //     // elevation: 55,
            //         //     backgroundColor: Colors.white.withOpacity(0.01),
            //         //     //orangeColor.withOpacity(0.7),
            //         //     primary: orangeColor,
            //         //     shape: RoundedRectangleBorder(
            //         //         borderRadius: BorderRadius.circular(25)),
            //         //   ),
            //         //   onPressed: () {},
            //         //   child: Text('xxx'),
            //         // ),
            //         // ElevatedButton(onPressed: () {}, child: Text('yyy')),
            //       ],
            //     )
            //   ],
            // )
            // ElevatedButton(onPressed: () {}, child: Text('yyy')),
          ],
        ),
      ),
    );
  }
}
