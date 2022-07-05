// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/user_model.dart';
import 'package:home_workout_app/view_models/another_user_profile_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view_widgets.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    // int id = args['id'];

    Provider.of<ProfileViewModel>(context, listen: false).setCurrentUserData();
  }

  String finishedWorkouts = 'Finished Workouts'.tr();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Provider.of<ProfileViewModel>(context, listen: true).getIsLoading
        ? CustomLoading()
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedOpacity(
                  opacity: Provider.of<ProfileViewModel>(context, listen: true)
                          .getInfoWidgetVisible
                      ? 1
                      : 0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedContainer(
                    color: Colors.transparent,
                    duration: const Duration(milliseconds: 300),
                    //height: user.getInfoWidgetVisible ? 100 : 0,
                    child: Row(
                      children: [
                        Consumer<ProfileViewModel>(
                          builder: (context, user, child) => CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(user.getUserData.imageUrl),
                            onBackgroundImageError: (child, stacktrace) =>
                                const LoadingContainer(),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: user.getUserData.role == 'manager'
                                        ? Colors.red.shade900
                                        : (user.getUserData.role == 'coach'
                                            ? blueColor
                                            : orangeColor),
                                    width: 2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Consumer<ProfileViewModel>(
                            builder: (context, user, child) => Text(
                              '${user.getUserData.fname} ${user.getUserData.lname}',
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
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
                          builder: (context, user, child) => VisibilityDetector(
                            key: Key(user.getUserData.id),
                            onVisibilityChanged: (VisibilityInfo info) {
                              if (info.visibleBounds.isEmpty)
                                user.setInfoWidgetVisible(true);
                              else
                                user.setInfoWidgetVisible(false);
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(user.getUserData.imageUrl),
                              onBackgroundImageError: (child, stacktrace) =>
                                  const LoadingContainer(),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: user.getUserData.role == 'manager'
                                          ? Colors.red.shade900
                                          : (user.getUserData.role == 'coach'
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
                      Consumer<ProfileViewModel>(
                        builder: (context, user, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${user.getUserData.fname} ${user.getUserData.lname}',
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              ' ( ${user.getUserData.role.toUpperCase()} )',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: user.getUserData.role == 'manager'
                                    ? Colors.red.shade900
                                    : (user.getUserData.role == 'coach'
                                        ? blueColor
                                        : orangeColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<ProfileViewModel>(
                        builder: (context, user, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (user.getUserData.roleId == 2 ||
                                user.getUserData.roleId == 3)
                              TextButton(
                                onPressed: () async {
                                  await user.setFollowers(
                                      5,
                                      context.locale == Locale('en')
                                          ? 'en'
                                          : 'ar');
                                  showBottomList(
                                      context, 'Followers', user.getFollowings);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Followers',
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
                                              color: blueColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      user.getUserData.followers.toString(),
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
                                              color: greyColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            TextButton(
                              onPressed: () async {
                                await user.setFollowings(
                                    5,
                                    context.locale == Locale('en')
                                        ? 'en'
                                        : 'ar');
                                showBottomList(
                                    context, 'Followings', user.getFollowers);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Followings',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: blueColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    user.getUserData.followings.toString(),
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: context.locale == Locale('en')
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          child: Text(
                            'Bio',
                            style: theme.textTheme.bodySmall,
                          ).tr(),
                        ),
                      ),
                      Consumer<ProfileViewModel>(
                        builder: (context, user, child) => user
                                    .getUserData.bio ==
                                ''
                            ? Text(
                                'Tell others something about you!',
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: greyColor, fontSize: 15),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: blueColor),
                                ),
                                child: Text(
                                  user.getUserData.bio,
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                      ),
                      if (Provider.of<ProfileViewModel>(context, listen: true)
                                  .getUserData
                                  .role ==
                              'coach' ||
                          Provider.of<ProfileViewModel>(context, listen: true)
                                  .getUserData
                                  .role ==
                              'dietitian')
                        ExpansionTile(
                          iconColor: blueColor,
                          title: Text(
                            'Shared workouts',
                            style: theme.textTheme.bodySmall,
                          ).tr(),
                        ),
                      if (Provider.of<ProfileViewModel>(context, listen: true)
                                  .getUserData
                                  .role ==
                              'coach' ||
                          Provider.of<ProfileViewModel>(context, listen: true)
                                  .getUserData
                                  .role ==
                              'dietitian')
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
                              Consumer<ProfileViewModel>(
                                builder: (context, user, child) =>
                                    CircularPercentIndicator(
                                  radius: 50,
                                  animation: true,
                                  center: Text(
                                    '$finishedWorkouts \n ${user.getUserData.finishedWorkouts}/${user.getUserData.enteredWorkouts}',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        fontSize: 10, color: blueColor),
                                  ),
                                  progressColor: blueColor,
                                  percent: user.getUserData.finishedWorkouts /
                                      user.getUserData.enteredWorkouts,
                                ),
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
