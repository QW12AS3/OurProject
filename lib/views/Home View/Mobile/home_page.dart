import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/mobile_home_view_model.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view_widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Consumer<MobileHomeViewModel>(
              builder: (context, consumer, child) => Row(
                children: consumer.categories.entries
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          consumer.changeSelectedCategorie(e.key, true);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: e.value ? blueColor : greyColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              e.key,
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                  fontSize: e.value ? 15 : 10),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Consumer<MobileHomeViewModel>(
            builder: (context, workouts, child) => Column(
                children: workouts
                    .getWorkouts()
                    .where((element) =>
                        element.categorie ==
                        workouts.categories.entries
                            .firstWhere((element) => element.value == true)
                            .key)
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(e.imageUrl),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Coach ${e.publisherName}',
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(color: blueColor),
                                    ),
                                    Text(
                                      '6/3/2022 - 5:33 PM',
                                      style: theme.textTheme.displaySmall!
                                          .copyWith(
                                              color: greyColor, fontSize: 10),
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
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image(
                                      loadingBuilder:
                                          (context, child, loadingProgress) =>
                                              loadingProgress != null
                                                  ? const LoadingContainer()
                                                  : child,
                                      width: mq.width * 0.95,
                                      height: 250,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(e.imageUrl),
                                    ),
                                  ),
                                  Container(
                                    width: mq.width * 0.95,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.65),
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                e.name,
                                                style: theme
                                                    .textTheme.displaySmall,
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                'Exercises: ${e.excersises}',
                                                style: theme
                                                    .textTheme.displaySmall,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  Icons.alarm,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                                Text(
                                                  '${e.excpectedTime} min',
                                                  style: theme
                                                      .textTheme.displaySmall!
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
                        ),
                      ),
                    )
                    .toList()),
          )
        ],
      ),
    );
  }
}
