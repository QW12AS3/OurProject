// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
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
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Provider.of<ProfileViewModel>(context, listen: false).setCurrentUserData();
    Future.delayed(Duration.zero).then((value) {
      Provider.of<ProfileViewModel>(context, listen: false)
          .setInfoWidgetVisible(false);
      Provider.of<ProfileViewModel>(context, listen: false)
          .setHealthRecord(context.locale == Locale('en') ? 'en' : 'ar');

      _scrollController.addListener(() {
        if (_scrollController.offset ==
                _scrollController.position.maxScrollExtent &&
            Provider.of<ProfileViewModel>(context, listen: false)
                .getPostIsOpened) {
          Provider.of<ProfileViewModel>(context, listen: false)
              .setUserPosts(context.locale == const Locale('en') ? 'en' : 'ar');
        }
      });
    });
  }

  String finishedWorkouts = 'Finished Workouts'.tr();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Provider.of<ProfileViewModel>(context, listen: true).getIsLoading
        ? const CustomLoading()
        : RefreshIndicator(
            color: orangeColor,
            onRefresh: () async {
              Provider.of<ProfileViewModel>(context, listen: false).setPage(0);
              Provider.of<ProfileViewModel>(context, listen: false)
                  .clearPosts();
              await Provider.of<ProfileViewModel>(context, listen: false)
                  .setCurrentUserData(context);
              await Provider.of<ProfileViewModel>(context, listen: false)
                  .setHealthRecord(
                      context.locale == const Locale('en') ? 'en' : 'ar');
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: AnimatedOpacity(
                    opacity:
                        Provider.of<ProfileViewModel>(context, listen: true)
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
                                      color: user.getUserData.roleId == 2
                                          ? orangeColor
                                          : (user.getUserData.roleId == 3
                                              ? blueColor
                                              : Colors.transparent),
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
                    controller: _scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Consumer<ProfileViewModel>(
                            builder: (context, user, child) =>
                                VisibilityDetector(
                              key: Key(user.getUserData.id.toString()),
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
                                        color: user.getUserData.roleId == 2
                                            ? orangeColor
                                            : (user.getUserData.roleId == 3
                                                ? blueColor
                                                : Colors.transparent),
                                        width: 2),
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
                              if (user.getUserData.roleId == 2 ||
                                  user.getUserData.roleId == 3)
                                Text(
                                  ' ( ${user.getUserData.role.toUpperCase()} )',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    color: user.getUserData.roleId == 2
                                        ? orangeColor
                                        : (user.getUserData.roleId == 3
                                            ? blueColor
                                            : Colors.transparent),
                                  ),
                                ),
                              Align(
                                alignment: context.locale == const Locale('en')
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                child: Consumer<ProfileViewModel>(
                                  builder: (context, user, child) =>
                                      PopupMenuButton<String>(
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: blueColor,
                                    ),
                                    onSelected: (String result) async {
                                      switch (result) {
                                        case 'edit':
                                          Navigator.pushNamed(context,
                                              '/editProfile', arguments: {
                                            'userData':
                                                Provider.of<ProfileViewModel>(
                                                        context,
                                                        listen: false)
                                                    .getUserData
                                          });
                                          break;
                                        case 'delete':
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext ctx) =>
                                                      AlertDialog(
                                                        title: Text(
                                                          'Are you sure to delete your account ?',
                                                          style: theme.textTheme
                                                              .bodySmall,
                                                        ).tr(),
                                                        content: SizedBox(
                                                          height: sharedPreferences
                                                                      .getBool(
                                                                          'provider') ==
                                                                  true
                                                              ? 25
                                                              : 75,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'Note: You can reactive your account in 30 days.',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color:
                                                                            greyColor,
                                                                        fontSize:
                                                                            12),
                                                              ).tr(),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              if (sharedPreferences
                                                                      .getBool(
                                                                          'provider') ==
                                                                  false)
                                                                TextField(
                                                                  obscureText:
                                                                      true,
                                                                  controller:
                                                                      passwordController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .visiblePassword,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    label: FittedBox(
                                                                        child: const Text('Password')
                                                                            .tr()),
                                                                    floatingLabelStyle: theme
                                                                        .textTheme
                                                                        .bodySmall,
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color:
                                                                              orangeColor,
                                                                          width:
                                                                              1.5),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            15),
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color:
                                                                              greyColor,
                                                                          width:
                                                                              1.5),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            15),
                                                                      ),
                                                                    ),
                                                                    errorBorder:
                                                                        const OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .red,
                                                                          width:
                                                                              1.5),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            15),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color:
                                                                              orangeColor,
                                                                          width:
                                                                              1.5),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            15),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await user.deleteAccount(
                                                                  passwordController
                                                                      .text
                                                                      .trim(),
                                                                  context.locale ==
                                                                          const Locale(
                                                                              'en')
                                                                      ? 'en'
                                                                      : 'ar',
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Yes',
                                                              style: theme
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ).tr(),
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    ctx);
                                                              },
                                                              child: Text(
                                                                'Cancel',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color:
                                                                            blueColor),
                                                              ).tr())
                                                        ],
                                                      ));
                                          break;
                                        case 'blocklist':
                                          await user.setBlocklist(
                                              context.locale == Locale('en')
                                                  ? 'en'
                                                  : 'ar');
                                          showBottomList(context, 'Blocklist',
                                              user.getBlocklist);

                                          break;
                                        default:
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'edit',
                                        child: Text(
                                          'Edit profile',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(color: blueColor),
                                        ).tr(),
                                      ),
                                      if (user.getUserData.roleId != 1)
                                        PopupMenuItem<String>(
                                          value: 'blocklist',
                                          child: Text(
                                            'Blocklist',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(color: blueColor),
                                          ).tr(),
                                        ),
                                      PopupMenuItem<String>(
                                        value: 'delete',
                                        child: Text(
                                          'Delete account',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(color: Colors.red),
                                        ).tr(),
                                      ),
                                    ],
                                  ),
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
                                        user.getUserData.id,
                                        context.locale == Locale('en')
                                            ? 'en'
                                            : 'ar');
                                    showBottomList(context, 'Followers',
                                        user.getFollowers);
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
                                      ).tr(),
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
                                      user.getUserData.id,
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
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
                                              color: blueColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                    ).tr(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      user.getUserData.followings.toString(),
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
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
                                ).tr()
                              : Container(
                                  width: mq.size.width * 0.95,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),
                        if (Provider.of<ProfileViewModel>(context, listen: true)
                                    .getUserData
                                    .roleId ==
                                2 ||
                            Provider.of<ProfileViewModel>(context, listen: true)
                                    .getUserData
                                    .roleId ==
                                3)
                          ExpansionTile(
                            iconColor: blueColor,
                            title: Text(
                              'Shared workouts',
                              style: theme.textTheme.bodySmall,
                            ).tr(),
                          ),
                        if (Provider.of<ProfileViewModel>(context, listen: true)
                                    .getUserData
                                    .roleId ==
                                2 ||
                            Provider.of<ProfileViewModel>(context, listen: true)
                                    .getUserData
                                    .roleId ==
                                3)
                          Consumer<ProfileViewModel>(
                            builder: (context, user, child) => ExpansionTile(
                              onExpansionChanged: (change) async {
                                if (change) {
                                  user.setPostIsOpened(true);
                                  user.setPage(0);
                                  user.clearPosts();
                                  await user.setUserPosts(
                                      context.locale == Locale('en')
                                          ? 'en'
                                          : 'ar');
                                } else {
                                  user.setPostIsOpened(false);

                                  user.clearPosts();
                                }
                              },
                              iconColor: blueColor,
                              title: Text(
                                'Shared posts',
                                style: theme.textTheme.bodySmall,
                              ).tr(),
                              children: (user.getIsPostLogoutLoading &&
                                      user.getUserPosts.isEmpty)
                                  ? [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child:
                                                bigLoader(color: orangeColor)),
                                      ),
                                    ]
                                  : user.getUserPosts.map((e) {
                                      if (e.type == 2 || e.type == 3)
                                        return pollPostCard(
                                            post: e, ctx: context);
                                      else
                                        return NormalPostCard(
                                            post: e, ctx: context);
                                    }).toList(),
                            ),
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
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
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
                        ExpansionTile(
                          iconColor: blueColor,
                          title: Text(
                            'Health record',
                            style: theme.textTheme.bodySmall,
                          ).tr(),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (Provider.of<ProfileViewModel>(context,
                                            listen: true)
                                        .getHealthRecord
                                        .desc
                                        .isNotEmpty ||
                                    Provider.of<ProfileViewModel>(context,
                                            listen: true)
                                        .getHealthRecord
                                        .diseases
                                        .isNotEmpty)
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/editHealthRecord');
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 15,
                                    ),
                                  ),
                                if (Provider.of<ProfileViewModel>(context,
                                            listen: true)
                                        .getHealthRecord
                                        .desc
                                        .isNotEmpty ||
                                    Provider.of<ProfileViewModel>(context,
                                            listen: true)
                                        .getHealthRecord
                                        .diseases
                                        .isNotEmpty)
                                  Consumer<ProfileViewModel>(
                                    builder: (context, user, child) => user
                                            .getIseditLoading
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: smallLoader(
                                              color: Colors.red,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              await Provider.of<
                                                          ProfileViewModel>(
                                                      context,
                                                      listen: false)
                                                  .deleteHealthRecord(
                                                      context.locale ==
                                                              const Locale('en')
                                                          ? 'en'
                                                          : 'ar',
                                                      context);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                          ),
                                  )
                              ],
                            ),
                            if (Provider.of<ProfileViewModel>(context,
                                        listen: true)
                                    .getHealthRecord
                                    .desc
                                    .isEmpty &&
                                Provider.of<ProfileViewModel>(context,
                                        listen: true)
                                    .getHealthRecord
                                    .diseases
                                    .isEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "You don't have an health record ",
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: greyColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ).tr(),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/addHealthRecord');
                                      },
                                      child: Text(
                                        'add now +',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
                                                color: orangeColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                decoration:
                                                    TextDecoration.underline),
                                      ).tr()),
                                ],
                              ),
                            if (Provider.of<ProfileViewModel>(context,
                                    listen: true)
                                .getHealthRecord
                                .desc
                                .isNotEmpty)
                              Align(
                                alignment: context.locale == Locale('en')
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 2),
                                  child: Text(
                                    'Description',
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.w300),
                                  ).tr(),
                                ),
                              ),
                            Consumer<ProfileViewModel>(
                              builder: (context, user, child) => user
                                      .getHealthRecord.desc.isEmpty
                                  ? const Text('')
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: mq.size.width * 0.95,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(color: blueColor),
                                        ),
                                        child: Text(
                                          user.getHealthRecord.desc,
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                            ),
                            if (Provider.of<ProfileViewModel>(context,
                                    listen: true)
                                .getHealthRecord
                                .diseases
                                .isNotEmpty)
                              Align(
                                alignment: context.locale == Locale('en')
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 2),
                                  child: Text(
                                    'Diseases',
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.w300),
                                  ).tr(),
                                ),
                              ),
                            Consumer<ProfileViewModel>(
                              builder: (context, user, child) => user
                                      .getHealthRecord.diseases.isEmpty
                                  ? const Text('')
                                  : ListBody(
                                      children: user.getHealthRecord.diseases
                                          .map(
                                            (e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              child: Text(
                                                  e['dis_name'].toString(),
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: blueColor)),
                                            ),
                                          )
                                          .toList(),
                                    ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
