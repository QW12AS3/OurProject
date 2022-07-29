import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/user_model.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/mobile_home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../view_models/profile_view_model.dart';

class workoutCard extends StatelessWidget {
  workoutCard(
      {required this.publisherName,
      required this.imageUrl,
      required this.exercisesNum,
      required this.min,
      required this.publisherImageUrl,
      required this.workoutName,
      Key? key})
      : super(key: key);

  String publisherName;
  String publisherImageUrl;
  String workoutName;
  String imageUrl;
  int exercisesNum;
  int min;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/anotherUserProfile',
                arguments: {'id': 1});
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(publisherImageUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coach $publisherName',
                    style:
                        theme.textTheme.bodySmall!.copyWith(color: blueColor),
                  ),
                  Text(
                    '6/3/2022 - 5:33 PM',
                    style: theme.textTheme.displaySmall!
                        .copyWith(color: greyColor, fontSize: 10),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          width: mq.width * 0.95,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: blueColor, width: 2),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress != null
                          ? const LoadingContainer()
                          : child,
                  width: mq.width * 0.95,
                  height: 250,
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
              Container(
                width: mq.width * 0.95,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: orangeColor.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FittedBox(
                          child: Text(
                            workoutName,
                            style: theme.textTheme.displaySmall,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            'Exercises: $exercisesNum',
                            style: theme.textTheme.displaySmall,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.alarm,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              '$min min',
                              style: theme.textTheme.displaySmall!
                                  .copyWith(fontSize: 15),
                            )
                          ],
                        ),
                        // FittedBox(
                        //   child: Text(
                        //     'Published by:\ncoach ${e.publisherName}',
                        //     style: theme.textTheme.displaySmall,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        width: mq.width * 0.95,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
      ),
    );
  }
}

class myDrawer extends StatelessWidget {
  myDrawer({required this.user, required this.tabController, Key? key})
      : super(key: key);

  UserModel user;
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                tabController.animateTo(2);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.imageUrl),
                    onBackgroundImageError: (child, stacktrace) =>
                        const LoadingContainer(),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: user.roleId == 2
                                ? orangeColor
                                : (user.roleId == 3
                                    ? blueColor
                                    : Colors.transparent),
                            width: 2),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${user.fname} ${user.lname}',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      if (user.roleId != 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            user.role,
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: user.roleId == 2
                                    ? orangeColor
                                    : (user.roleId == 3
                                        ? blueColor
                                        : Colors.transparent),
                                fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: blueColor,
            thickness: 2,
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text(
                'Settings',
                style: theme.textTheme.bodySmall,
              ).tr(),
              trailing: Icon(
                Icons.settings,
                color: blueColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/savedPosts');
            },
            child: ListTile(
              title: Text(
                'Saved posts',
                style: theme.textTheme.bodySmall,
              ).tr(),
              trailing: Icon(
                Icons.star_rate_rounded,
                color: blueColor,
              ),
            ),
          ),
          if (!Provider.of<ProfileViewModel>(context, listen: true)
              .getIsLogoutLoading)
            ExpansionTile(
              trailing: const Icon(
                Icons.logout_rounded,
                color: Colors.red,
              ),
              title: Text(
                'Logout',
                style: theme.textTheme.bodySmall,
              ).tr(),
              iconColor: blueColor,
              children: [
                InkWell(
                  onTap: () async {
                    await Provider.of<ProfileViewModel>(context, listen: false)
                        .logout(context);

                    sharedPreferences.remove("access_token");
                    sharedPreferences.remove("refresh_token");
                    sharedPreferences.remove("token_expiration");
                    sharedPreferences.remove("role_id");
                    sharedPreferences.remove("role_name");
                    sharedPreferences.remove("googleProvider");
                    sharedPreferences.remove("is_verified");
                    sharedPreferences.remove("is_info");
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/start', (route) => false);
                  },
                  child: ListTile(
                    title: Text(
                      'From this device',
                      style: theme.textTheme.bodySmall,
                    ).tr(),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Provider.of<ProfileViewModel>(context, listen: false)
                        .logoutFromAll(context);
                    sharedPreferences.remove("access_token");
                    sharedPreferences.remove("refresh_token");
                    sharedPreferences.remove("token_expiration");
                    sharedPreferences.remove("role_id");
                    sharedPreferences.remove("role_name");
                    sharedPreferences.remove("googleProvider");
                    sharedPreferences.remove("is_verified");
                    sharedPreferences.remove("is_info");
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/start', (route) => false);
                  },
                  child: ListTile(
                    title: Text(
                      'From all devices',
                      style: theme.textTheme.bodySmall,
                    ).tr(),
                  ),
                ),
              ],
            )
          else
            bigLoader(
              color: orangeColor,
            ),
          if (!Provider.of<ProfileViewModel>(context, listen: true)
              .getIsLogoutLoading)
            ExpansionTile(
              trailing: const Icon(
                Icons.accessibility_new_outlined,
                color: Colors.red,
              ),
              title: Text(
                'Challenges',
                style: theme.textTheme.bodySmall,
              ).tr(),
              iconColor: blueColor,
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pushNamed('/challenges');
                  },
                  child: ListTile(
                    title: Text(
                      'My challenges',
                      style: theme.textTheme.bodySmall,
                    ).tr(),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pushNamed('/createChallenge');
                  },
                  child: ListTile(
                    title: Text(
                      'My created challenges',
                      style: theme.textTheme.bodySmall,
                    ).tr(),
                  ),
                ),
              ],
            )
          else
            bigLoader(
              color: orangeColor,
            ),
        ],
      ),
    );
  }
}
