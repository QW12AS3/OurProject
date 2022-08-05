import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/mobile_home_view_model.dart';

import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    var role_id = sharedPreferences.getInt("role_id");
    return Scaffold(
      floatingActionButton: (role_id == 2 || role_id == 4 || role_id == 5)
          ? FloatingActionButton(
              onPressed: () {
                buildDialog(context);
              },
              child: Icon(Icons.add),
            )
          : Container(),
      body: Container(
        child: mq.orientation == Orientation.portrait
            ? SingleChildScrollView(
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
                                    consumer.changeSelectedCategorie(
                                        e.key, true);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        color: e.value ? blueColor : greyColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        e.key,
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
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
                                        .firstWhere(
                                            (element) => element.value == true)
                                        .key)
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: workoutCard(
                                      publisherName: e.publisherName,
                                      imageUrl: e.imageUrl,
                                      exercisesNum: e.excersises,
                                      min: e.excpectedTime,
                                      publisherImageUrl: e.imageUrl,
                                      workoutName: e.name,
                                    ),
                                  ),
                                )
                                .toList())),
                  ],
                ),
              )
            : Consumer<MobileHomeViewModel>(
                builder: (context, workouts, child) => Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<MobileHomeViewModel>(
                        builder: (context, consumer, child) => Row(
                          children: consumer.categories.entries
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    consumer.changeSelectedCategorie(
                                        e.key, true);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        color: e.value ? blueColor : greyColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        e.key,
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
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
                    Expanded(
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 40,
                        ),
                        children: workouts
                            .getWorkouts()
                            .where((element) =>
                                element.categorie ==
                                workouts.categories.entries
                                    .firstWhere(
                                        (element) => element.value == true)
                                    .key)
                            .map(
                              (e) => workoutCard(
                                publisherName: e.publisherName,
                                imageUrl: e.imageUrl,
                                exercisesNum: e.excersises,
                                min: e.excpectedTime,
                                publisherImageUrl: e.imageUrl,
                                workoutName: e.name,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void buildDialog(BuildContext context) {
    final alert = AlertDialog(
      title: Text(
        'Add type',
        style: TextStyle(color: blueColor),
      ),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Divider(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  '/createExercise',
                );
              },
              child: Text(
                'Add exercise',
                style: TextStyle(color: orangeColor),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  '/createWorkout',
                );
              },
              child: Text(
                'Add workout',
                style: TextStyle(color: orangeColor),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        // barrierDismissible: false,
        // barrierLabel: "ddddddddd",
        barrierColor: orangeColor.withOpacity(0.1),
        builder: (BuildContext ctx) {
          return alert;
        });
  }
}
