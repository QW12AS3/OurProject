import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/User%20Information%20View/user_information_widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserInformationView extends StatelessWidget {
  UserInformationView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      bottomNavigationBar: Image(
        height: mq.size.width * 0.1,
        width: double.infinity,
        fit: BoxFit.fill,
        image: const AssetImage('assets/images/wave_background.png'),
        filterQuality: FilterQuality.high,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  UserInfoCustomText(text: 'Your gender:'),
                  Consumer<UserInformationViewModel>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            value.changeGender(Gender.female);
                          },
                          child: GenderContainer(
                              color: value.gender == Gender.female
                                  ? orangeColor
                                  : greyColor,
                              imagePath: 'assets/images/female.png'),
                        ),
                        InkWell(
                          onTap: () {
                            value.changeGender(Gender.male);
                          },
                          child: GenderContainer(
                              color: value.gender == Gender.male
                                  ? orangeColor
                                  : greyColor,
                              imagePath: 'assets/images/male.png'),
                        ),
                      ],
                    ),
                  ),
                  UserInfoCustomText(text: 'Your birthdate:'),
                  Consumer<UserInformationViewModel>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd').format(value.birthdate) ==
                                  DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now())
                              ? 'Year-Month-Day'
                              : DateFormat('yyyy-MM-dd')
                                  .format(value.birthdate),
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: blueColor),
                        ),
                        IconButton(
                          onPressed: () {
                            value.changeBirthdate(context);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: orangeColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  UserInfoCustomText(text: 'Your Height & Weight:'),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mq.size.width * 0.28),
                            child: TextFormField(
                              validator: (value) {
                                if (double.tryParse(value.toString()) == null) {
                                  return 'Invalid height';
                                }
                              },
                              onSaved: (val) {},
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Consumer<UserInformationViewModel>(
                                  builder: (context, value, child) => Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (value.weightUnit != Units.cm) {
                                            value.ChangeHeightUnit(Units.cm);
                                          }
                                        },
                                        child: Text(
                                          'cm',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                                  fontSize: value.heightUnit ==
                                                          Units.cm
                                                      ? 17
                                                      : 15,
                                                  color: value.heightUnit ==
                                                          Units.cm
                                                      ? orangeColor
                                                      : greyColor),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (value.weightUnit != Units.inch) {
                                            value.ChangeHeightUnit(Units.inch);
                                          }
                                        },
                                        child: Text(
                                          'inch',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                                  fontSize: value.heightUnit ==
                                                          Units.inch
                                                      ? 17
                                                      : 15,
                                                  color: value.heightUnit ==
                                                          Units.inch
                                                      ? orangeColor
                                                      : greyColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.height,
                                  color: orangeColor,
                                ),
                                label: const Text('Height'),
                                floatingLabelStyle: theme.textTheme.bodySmall,
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: orangeColor, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: greyColor, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: orangeColor, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mq.size.width * 0.28, vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (double.tryParse(value.toString()) == null) {
                                return 'Invalid weight';
                              }
                            },
                            onSaved: (val) {},
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixIcon: Consumer<UserInformationViewModel>(
                                builder: (context, value, child) => Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (value.weightUnit != Units.kg) {
                                          value.ChangeWeightUnit(Units.kg);
                                        }
                                      },
                                      child: Text(
                                        'Kg',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
                                                fontSize:
                                                    value.weightUnit == Units.kg
                                                        ? 15
                                                        : 12,
                                                color:
                                                    value.weightUnit == Units.kg
                                                        ? orangeColor
                                                        : greyColor),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (value.weightUnit != Units.lb) {
                                          value.ChangeWeightUnit(Units.lb);
                                        }
                                      },
                                      child: Text(
                                        'lb',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
                                                fontSize:
                                                    value.weightUnit == Units.lb
                                                        ? 17
                                                        : 15,
                                                color:
                                                    value.weightUnit == Units.lb
                                                        ? orangeColor
                                                        : greyColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.monitor_weight_outlined,
                                color: orangeColor,
                              ),
                              label: const Text('Weight'),
                              floatingLabelStyle: theme.textTheme.bodySmall,
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: mq.size.width * 0.24,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState != null) {
                          if (_formkey.currentState!.validate()) {
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear);
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Next'),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 50,
              height: 150,
              color: orangeColor,
            )
          ],
        ),
      ),
    );
  }
}
