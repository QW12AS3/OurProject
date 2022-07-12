import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/otp_view_model.dart';
import 'package:provider/provider.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  TextEditingController c_nameController =
      TextEditingController(text: ''); //TODO: add cname
  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Image(
          height: mq.size.height * 0.1,
          width: double.infinity,
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/wave_background.png'),
          filterQuality: FilterQuality.high,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: mq.size.height * 0.2,
                  width: mq.size.width * 0.2,
                  child: Image.asset(
                    'assets/images/Envelope.png',
                    // color: orangeColor,
                  ),
                  // Icon(
                  //   Icons.message,
                  //   color: orangeColor,
                  //   size: (mq.size.height * 0.1 + mq.size.width * 0.1) / 2,
                  // ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  child: Text(
                    ' Please enter the code sent to your Email ',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 10,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.size.height * 0.1,
                            vertical: mq.size.width * 0.05),
                        child: Container(
                          width: 380,
                          decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Consumer<otpViewModel>(
                            builder: ((context, value, _) => TextFormField(
                                  controller: otpController,
                                  validator: (value) {
                                    return otpViewModel()
                                        .checkCode(value.toString());
                                  },
                                  decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
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
                                    hintText: " * * * * * ",
                                    // helperText: " R R R R",
                                    // counterText: "W WW w",
                                    // suffixText: "sss ss",
                                    hintStyle: TextStyle(
                                        color: blueColor.withOpacity(0.7),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w900),
                                    labelText: 'Validation code',
                                    labelStyle: TextStyle(
                                        color: orangeColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: Icon(
                                      Icons.verified_user_outlined,
                                      color: blueColor,
                                      size: 33,
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          onPressed: () {
                                            Provider.of<otpViewModel>(context,
                                                    listen: false)
                                                .changeCodeobscure();
                                          },
                                          icon: Icon(
                                            Provider.of<otpViewModel>(context)
                                                    .obscureCode
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: blueColor,
                                            size: 33,
                                          )),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: blueColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  obscureText:
                                      Provider.of<otpViewModel>(context)
                                          .obscureCode,
                                  obscuringCharacter: 'X',
                                  maxLength: 5,
                                  textAlign: TextAlign.center,
                                  cursorHeight: 30,
                                  showCursor: false,
                                  // readOnly: false,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),

                Container(
                  height: 40,
                  width: 110,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                        // use the email provided here

                        final BackEndMessage = await otpViewModel()
                            .postUserInfo(
                                otpController.text,
                                c_nameController.text == null
                                    ? ''
                                    : c_nameController.text,
                                (routeArg['state'] == 'sign 201' ||
                                        routeArg['state'] == 'update email')
                                    ? '/emailVerfiy/'
                                    : '/user/recover');
                        print(BackEndMessage);
                        final sBar = SnackBar(
                            // margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(33)),
                            content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(BackEndMessage.message ?? '')));
                        if (BackEndMessage.message != null &&
                            BackEndMessage.message != '') {
                          ScaffoldMessenger.of(context).showSnackBar(sBar);
                        }
                        if (BackEndMessage.statusCode == 201) {
                          otpController.clear();
                          c_nameController.clear();
                          try {
                            Navigator.of(context).pushReplacementNamed(
                              (routeArg['state'] == 'sign 201' ||
                                      routeArg['state'] == 'sign 250')
                                  ? '/userinfo'
                                  : '/home',
                            );
                          } catch (e) {
                            print('navigate from otp error: $e');
                          }
                        }
                      }
                    },
                    child: const Text('Verify'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t receive the code?',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () async {
                          final BackEndMessage = await otpViewModel()
                              .postUserInfo(
                                  otpController.text,
                                  c_nameController.text == null
                                      ? ''
                                      : c_nameController.text,
                                  (routeArg['state'] == 'sign 201' ||
                                          routeArg['state'] == 'update email')
                                      ? '/emailVerfiy/reget'
                                      : '/user/recover/reget');
                        },
                        child: Text(
                          'Resend again',
                          style: theme.textTheme.bodySmall,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//4321
//   SizedBox enteredSquare(BuildContext context, bool first, bool last) {
//     return SizedBox(
//       height: 68,
//       width: 64,
//       child: TextFormField(
//         onChanged: ((value) {
//           // if (value.length == 0 && !first) {
//           //   setState(() {
//           //     FocusScope.of(context).previousFocus();
//           //   });
//           // }
//           // if (value.length == 1 && !last) {
//           //   setState(() {
//           //     FocusScope.of(context).nextFocus();
//           //   });
//           // }
//         }),
//         decoration: InputDecoration(
//           hintText: " . . . ",
//           // hintTextDirection:TextDecoration()
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 width: 2,
//               ),
//               borderRadius: BorderRadius.circular(12)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(width: 2, color: Colors.green),
//               borderRadius: BorderRadius.circular(12)),
//         ),
//         style: Theme.of(context).textTheme.headline6,
//         keyboardType: TextInputType.number,
//         obscureText: true,
//         obscuringCharacter: 'x',
//         textAlign: TextAlign.center,
//         maxLength: 3,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//       ),
//     );
//   }

// //  4567