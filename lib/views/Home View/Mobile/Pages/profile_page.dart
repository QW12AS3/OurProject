// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/user_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({required this.user, Key? key}) : super(key: key);

  UserModel user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).setUserData();
  }

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
                    backgroundImage: NetworkImage(widget.user.imageUrl),
                    onBackgroundImageError: (child, stacktrace) =>
                        const LoadingContainer(),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: widget.user.role == 'Manager'
                                ? Colors.red.shade900
                                : (widget.user.role == 'Coach'
                                    ? blueColor
                                    : orangeColor),
                            width: 2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.user.name,
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
                      key: Key(widget.user.id),
                      onVisibilityChanged: (VisibilityInfo info) {
                        if (info.visibleBounds.isEmpty)
                          value.setInfoWidgetVisible(true);
                        else
                          value.setInfoWidgetVisible(false);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(widget.user.imageUrl),
                        onBackgroundImageError: (child, stacktrace) =>
                            const LoadingContainer(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: widget.user.role == 'Manager'
                                    ? Colors.red.shade900
                                    : (widget.user.role == 'Coach'
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
                      widget.user.name,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      ' ( ${widget.user.role.toUpperCase()} )',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        color: widget.user.role == 'Manager'
                            ? Colors.red.shade900
                            : (widget.user.role == 'Coach'
                                ? blueColor
                                : orangeColor),
                      ),
                    ),
                  ],
                ),
                if (widget.user.id != '1' && widget.user.role == 'coach')
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      ' + Follow',
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: blueColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                if (widget.user.role == 'coach' ||
                    widget.user.role == 'dietitian')
                  ExpansionTile(
                    iconColor: blueColor,
                    title: Text(
                      'Shared workouts',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                if (widget.user.role == 'coach' ||
                    widget.user.role == 'dietitian')
                  ExpansionTile(
                    iconColor: blueColor,
                    title: Text(
                      'Shared posts',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularPercentIndicator(
                      radius: 50,
                      animation: true,
                      center: Text(
                        'Finished Workouts \n ${widget.user.finishedWorkouts}/${widget.user.enteredWorkouts}',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontSize: 10, color: blueColor),
                      ),
                      progressColor: blueColor,
                      percent: widget.user.finishedWorkouts /
                          widget.user.enteredWorkouts,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
