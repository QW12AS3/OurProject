import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/User%20Information%20View/user_information_widgets.dart';
import 'package:provider/provider.dart';

class UserInformationView extends StatelessWidget {
  const UserInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
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
            UserInfoCustomText(text: 'Your Age:'),
            Consumer<UserInformationViewModel>(
              builder: (context, value, child) => Column(
                children: [
                  Text(
                    value.age.ceil().toString(),
                    style:
                        theme.textTheme.bodySmall!.copyWith(color: blueColor),
                  ),
                  Slider(
                      divisions: 100,
                      inactiveColor: blueColor,
                      activeColor: orangeColor,
                      label: 'Age: ${value.age.ceil()}',
                      max: 100,
                      min: 10,
                      value: value.age,
                      onChanged: (selectedAge) {
                        value.changeAge(selectedAge);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
