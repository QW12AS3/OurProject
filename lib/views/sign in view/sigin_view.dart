import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/views/sign%20in%20view/sigin_widgets.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);
  final formGlobalKey = GlobalKey<FormState>();
  bool obscurePassword = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    TextEditingController emailController = new TextEditingController(text: '');
    TextEditingController passwordController =
        new TextEditingController(text: '');

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
                    height: mq.size.height * 0.3,
                  ),
                  SizedBox(
                    height: mq.size.height * 0.05,
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
                                  width: 400,
                                  decoration: BoxDecoration(
                                      color: Colors.white70.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      if (!checkVlaidation()
                                          .checkEmail(value.toString())) {
                                        return ' Invalid email';
                                      }
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
                                      color: Colors.white70.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      // if (value!.trim().isEmpty) {
                                      //   return " You have to fill the password";
                                      // } else if (value.trim().length < 6) {
                                      //   return " Password should be 6 characters or more";
                                      // }
                                      return checkVlaidation()
                                          .checkPassword(value.toString());
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
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                            color: orangeColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        prefixIcon: Icon(
                                          Icons.lock_outline_rounded,
                                          color: blueColor,
                                          size: 33,
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconButton(
                                            onPressed: () {
                                              obscurePassword =
                                                  !obscurePassword;
                                            },
                                            icon: Icon(
                                              obscurePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: blueColor,
                                              size: 33,
                                            ),
                                          ),
                                        )),
                                    style: TextStyle(
                                        color: blueColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    obscureText: obscurePassword,
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
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
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              formGlobalKey.currentState!.save();
                              // use the email provided here

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

class checkVlaidation {
  checkEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  String? checkPassword(String password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[/?,.!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Invalid password';
      } else {
        return null;
      }
    }
  }
}
