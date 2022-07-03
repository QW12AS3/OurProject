import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/user_model.dart';
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
        Row(
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
                  style: theme.textTheme.bodySmall!.copyWith(color: blueColor),
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
  myDrawer({required this.user, Key? key}) : super(key: key);

  UserModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                          color: user.role == 'Manager'
                              ? Colors.red.shade900
                              : (user.role == 'Coach'
                                  ? blueColor
                                  : orangeColor),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        user.role,
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: user.role == 'Manager'
                                ? Colors.red.shade900
                                : (user.role == 'Coach'
                                    ? blueColor
                                    : orangeColor),
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: blueColor,
            thickness: 2,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'editProfile', arguments: {
                'userData':
                    Provider.of<ProfileViewModel>(context, listen: false)
                        .getUserData
              });
            },
            child: ListTile(
              title: Text(
                'Edit profile',
                style: theme.textTheme.bodySmall,
              ).tr(),
              trailing: Icon(
                Icons.edit_note_rounded,
                color: blueColor,
              ),
            ),
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
          )
        ],
      ),
    );
  }
}
