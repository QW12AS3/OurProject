// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/user_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserModel user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).setUserData();
    user = Provider.of<ProfileViewModel>(context, listen: false).getUserData;
  }

  String finishedWorkouts = 'Finished Workouts'.tr();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: AnimatedOpacity(
            opacity: Provider.of<ProfileViewModel>(context, listen: true)
                    .getInfoWidgetVisible
                ? 1
                : 0,
            duration: const Duration(milliseconds: 300),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              //height: user.getInfoWidgetVisible ? 100 : 0,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user.imageUrl),
                    onBackgroundImageError: (child, stacktrace) =>
                        const LoadingContainer(),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: user.role == 'Manager'
                                ? Colors.red.shade900
                                : (user.role == 'Coach'
                                    ? blueColor
                                    : orangeColor),
                            width: 2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${user.fname} ${user.lname}',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Consumer<ProfileViewModel>(
                    builder: (context, value, child) => VisibilityDetector(
                      key: Key(user.id),
                      onVisibilityChanged: (VisibilityInfo info) {
                        if (info.visibleBounds.isEmpty)
                          value.setInfoWidgetVisible(true);
                        else
                          value.setInfoWidgetVisible(false);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(user.imageUrl),
                        onBackgroundImageError: (child, stacktrace) =>
                            const LoadingContainer(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: user.role == 'Manager'
                                    ? Colors.red.shade900
                                    : (user.role == 'Coach'
                                        ? blueColor
                                        : orangeColor),
                                width: 3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${user.fname} ${user.lname}',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      ' ( ${user.role.toUpperCase()} )',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        color: user.role == 'Manager'
                            ? Colors.red.shade900
                            : (user.role == 'Coach' ? blueColor : orangeColor),
                      ),
                    ),
                  ],
                ),
                if (user.id != '1' && user.role == 'coach')
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      ' + Follow',
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: blueColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                Align(
                  alignment: context.locale == Locale('en')
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Text(
                      'Bio',
                      style: theme.textTheme.bodySmall,
                    ).tr(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: blueColor),
                  ),
                  child: Text(
                    user.bio,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                if (user.role == 'coach' || user.role == 'dietitian')
                  ExpansionTile(
                    iconColor: blueColor,
                    title: Text(
                      'Shared workouts',
                      style: theme.textTheme.bodySmall,
                    ).tr(),
                  ),
                if (user.role == 'coach' || user.role == 'dietitian')
                  ExpansionTile(
                    iconColor: blueColor,
                    title: Text(
                      'Shared posts',
                      style: theme.textTheme.bodySmall,
                    ).tr(),
                  ),
                ExpansionTile(
                  iconColor: blueColor,
                  title: Text(
                    'Statistics',
                    style: theme.textTheme.bodySmall,
                  ).tr(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircularPercentIndicator(
                          radius: 50,
                          animation: true,
                          center: Text(
                            '$finishedWorkouts \n ${user.finishedWorkouts}/${user.enteredWorkouts}',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 10, color: blueColor),
                          ),
                          progressColor: blueColor,
                          percent: user.finishedWorkouts / user.enteredWorkouts,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
