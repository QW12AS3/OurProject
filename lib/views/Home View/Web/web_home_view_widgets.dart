import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';

class webWorkoutCard extends StatelessWidget {
  webWorkoutCard(
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
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return SizedBox(
      width: mq.size.width * 0.95,
      child: Column(
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
          Expanded(
            child: Container(
              width: mq.size.width * 0.95,
              //height: 400,
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
                      //width: mq.width * 0.95,
                      height: mq.size.longestSide,
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                  Container(
                    width: mq.size.width * 0.95,
                    height: mq.size.longestSide,
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
          ),
        ],
      ),
    );
  }
}

class webNormalPostCard extends StatelessWidget {
  webNormalPostCard(
      {required this.coachName,
      required this.coachImageUrl,
      required this.title,
      required this.postImages,
      required this.comments,
      required this.likes,
      Key? key})
      : super(key: key);

  String coachName;
  String coachImageUrl;
  List<String> postImages;
  String title;
  Map<String, int> likes;
  List<String> comments;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Center(
      child: Container(
        width: mq.size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: blueColor, width: 1.5),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(coachImageUrl),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coach $coachName',
                      style:
                          theme.textTheme.bodySmall!.copyWith(color: blueColor),
                    ),
                    Text(
                      '6/3/2022 - 5:33 PM',
                      style: theme.textTheme.displaySmall!
                          .copyWith(color: greyColor, fontSize: 10),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.black54),
              ),
            ),
            if (postImages.length == 1)
              Expanded(
                child: Image(
                  width: mq.size.width * 0.6,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    postImages[0],
                  ),
                ),
              ),
            if (postImages.length > 1)
              SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: postImages
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Image(
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    loadingProgress != null
                                        ? const LoadingContainer()
                                        : child,
                                width: mq.size.width * 0.6,
                                height: mq.size.height * 0.5,
                                fit: BoxFit.contain,
                                image: NetworkImage(e),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: IconButton(
                                  onPressed: () {
                                    _scrollController.animateTo(
                                        _scrollController.position.extentInside,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                  },
                                  icon: Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: orangeColor,
                                    size: 50,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            if (postImages.length > 1)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${postImages.length} Photos',
                    style: theme.textTheme.bodySmall!.copyWith(
                        color: greyColor,
                        fontWeight: FontWeight.w200,
                        fontSize: 12),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.abc),
                      Text(
                        likes['Like'].toString(),
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: blueColor, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.ac_unit_outlined),
                      Text(
                        likes['Dislike'].toString(),
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: blueColor, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      Text(
                        likes['Clap'].toString(),
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: blueColor, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.account_box_sharp),
                      Text(
                        likes['Strong'].toString(),
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: blueColor, fontSize: 15),
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Comments',
                            style: theme.textTheme.bodySmall,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                            color: orangeColor,
                          )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
