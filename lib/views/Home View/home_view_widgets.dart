import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:shimmer/shimmer.dart';

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
