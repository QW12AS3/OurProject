import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Register%20View%20Model/sign_in_view_model.dart';
import 'package:home_workout_app/models/sign_in_model.dart';
import 'package:home_workout_app/views/sign%20in%20view/sigin_widgets.dart';

import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController c_nameController = TextEditingController();

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
                    height: mq.size.height * 0.23,
                  ),
                  Container(
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
                                  ),
                                ),
                                Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                      color: Colors.white70.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      return signInViewModel()
                                          .checkEmail(value.toString());

                                      // if (value!.trim().isEmpty) {
                                      //   return ' You have to fill the Email';
                                      // } else if (!value.trim().contains('@') ||
                                      //     !value.trim().contains('.')) {

                                      // }
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
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Colors.white70.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Consumer<signInViewModel>(
                                        builder: ((context, value, _) =>
                                            TextFormField(
                                              controller: passwordController,
                                              validator: (value) {
                                                // if (value!.trim().isEmpty) {
                                                //   return " You have to fill the password";
                                                // } else if (value.trim().length < 6) {
                                                //   return " Password should be 6 characters or more";
                                                // }
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
                                                          Provider.of<signInViewModel>(
                                                                  context,
                                                                  listen: false)
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
                                                  fontWeight: FontWeight.bold),
                                              keyboardType: TextInputType.text,
                                              obscureText:
                                                  Provider.of<signInViewModel>(
                                                          context)
                                                      .obscurePassword,
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
                            // print('pppppppppppp');
                            if (formGlobalKey.currentState!.validate()) {
                              formGlobalKey.currentState!.save();
                              // use the email provided here
                              print('rrrrrrrrrrrrrrrrrrrr');

                              final BackEndMessage = await signInViewModel()
                                  .postUserInfo(
                                      emailController.text,
                                      passwordController.text,
                                      c_nameController.text);
                              print(BackEndMessage);
                              final sBar = SnackBar(
                                  content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${BackEndMessage.error == null ? "Welcome! ${BackEndMessage.f_name}" : BackEndMessage.error}"), ///////////////////////////////
                                ],
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(sBar);
                              if (BackEndMessage.access_token != '') {
                                emailController.clear();
                                passwordController.clear();
                                if (c_nameController != null)
                                  c_nameController.clear();
                                //Navigate
                              }
                            }
                          },
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
                              onPressed: () {},
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
                        IconButton(
                            onPressed: () {},
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
