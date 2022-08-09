import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/workout_list_model.dart';
import 'package:home_workout_app/view_models/Workout_View_Model/my_workouts_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';

class MyWorkouts extends StatefulWidget {
  const MyWorkouts({Key? key}) : super(key: key);

  @override
  State<MyWorkouts> createState() => _MyWorkoutsState();
}

class _MyWorkoutsState extends State<MyWorkouts> {
  final ListViewController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      Provider.of<MyWorkoutsViewModel>(context, listen: false).reset();
      Provider.of<MyWorkoutsViewModel>(context, listen: false).getWorkoutsData(
          getLang(context),
          Provider.of<MyWorkoutsViewModel>(context, listen: false).page,
          '/workout/my_workouts');
      print('ccccccccccccccccccccccccccc');
      ListViewController.addListener(() {
        if (ListViewController.position.maxScrollExtent ==
            ListViewController.offset) {
          Provider.of<MyWorkoutsViewModel>(context, listen: false)
              .setIsLoading(true);
          Provider.of<MyWorkoutsViewModel>(context, listen: false)
              .getWorkoutsData(
                  getLang(context),
                  Provider.of<MyWorkoutsViewModel>(context, listen: false).page,
                  '/workout/my_workouts');
          // print(object)
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    var role_id = sharedPreferences.getInt("role_id");
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: (role_id == 2 || role_id == 4 || role_id == 5)
        //     ? FloatingActionButton(
        //         onPressed: () {
        //           buildDialog(context);
        //         },
        //         child: Icon(Icons.add),
        //       )
        //     : Container(),
        appBar: AppBar(
          title: Text(
            'My workouts',
            style: theme.textTheme.bodyMedium!,
          ),
        ),
        body: Container(
            child: Column(
          children: [
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Consumer<MobileHomeViewModel>(
            //     builder: (context, consumer, child) => Row(
            //       children: consumer.categories.entries
            //           .map(
            //             (e) => InkWell(
            //               onTap: () {
            //                 consumer.changeSelectedCategorie(e.key, true);
            //               },
            //               child: Container(
            //                 margin: const EdgeInsets.all(4),
            //                 padding: const EdgeInsets.all(7),
            //                 decoration: BoxDecoration(
            //                     color: e.value ? blueColor : greyColor,
            //                     borderRadius: BorderRadius.circular(15)),
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(4),
            //                   child: Text(
            //                     e.key,
            //                     style: theme.textTheme.bodySmall!.copyWith(
            //                         color: Colors.white,
            //                         fontSize: e.value ? 15 : 10),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           )
            //           .toList(),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Consumer<MyWorkoutsViewModel>(
                builder: ((context, value, _) => (Provider.of<
                            MyWorkoutsViewModel>(context, listen: true)
                        .getfutureworkoutsList!
                        .isEmpty
                    ? bigLoader(color: orangeColor)
                    : RefreshIndicator(
                        onRefresh: () async {
                          Provider.of<MyWorkoutsViewModel>(context,
                                  listen: false)
                              .reset();
                          Provider.of<MyWorkoutsViewModel>(context,
                                  listen: false)
                              .getWorkoutsData(
                                  context.locale == Locale('en') ? 'en' : 'ar',
                                  Provider.of<MyWorkoutsViewModel>(context,
                                          listen: false)
                                      .page,
                                  '/workout/my_workouts');
                        },
                        child: ListView.builder(
                          controller: ListViewController,
                          physics: BouncingScrollPhysics(),
                          // scrollDirection: Axis.horizontal,
                          itemCount: value.getfutureworkoutsList?.length,
                          itemBuilder: ((context, index) {
                            if (index < value.getfutureworkoutsList!.length) {
                              final item = value.getfutureworkoutsList![index];
                              // return ListTile(title: Text(item));
                              return _buildList(context, index,
                                  value.getfutureworkoutsList![index]);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                        ),
                      ))),
              ),
            ),
            Provider.of<MyWorkoutsViewModel>(context, listen: true).isLoading ==
                    true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: bigLoader(color: orangeColor),
                  )
                : Container(),
          ],
        )),
      ),
    );
  }

  /* void buildDialog(BuildContext context) {
    final alert = AlertDialog(
      title: Text(
        'Create type',
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
                'Create exercise',
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
                'Create workout',
                style: TextStyle(color: orangeColor),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        barrierColor: orangeColor.withOpacity(0.1),
        builder: (BuildContext ctx) {
          return alert;
        });
  }
*/
  _buildList(BuildContext context, int index, WorkoutListModel workoutValue) {
    final mq = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/anotherUserProfile',
                    arguments: {'id': workoutValue.user_id});
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(workoutValue.prof_img_url
                                      .toString()
                                      .substring(0, 4) !=
                                  'http'
                              ? '$ip/${workoutValue.prof_img_url}'
                              : workoutValue.prof_img_url.toString()
                          // 'https://media.istockphoto.com/photos/various-sport-equipments-on-grass-picture-id949190756?s=612x612',
                          ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coach ${workoutValue.f_name}',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: blueColor),
                      ),
                      Text(
                        // '6/3/2022 - 5:33 PM', //TODO:
                        '${workoutValue.created_at}',
                        style: theme.textTheme.displaySmall!
                            .copyWith(color: greyColor, fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            ),
            if ((sharedPreferences.get("role_id") == 2 &&
                    workoutValue.user_id == 2) ||
                sharedPreferences.get("role_id") == 4 ||
                sharedPreferences.get("role_id") == 5) //TODO:
              IconButton(
                  onPressed: () {
                    Provider.of<MyWorkoutsViewModel>(context, listen: false)
                        .deleteSpecificChallengeData(
                            context.locale == Locale('en') ? 'en' : 'ar',
                            // 2
                            workoutValue.id);
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: blueColor,
                  ))
          ],
        ),
        InkWell(
          onTap: () {
            //TODO:
            // Navigator.pushNamed(context, '/anotherUserProfile',
            //     arguments: {'id': workoutValue.user_id});
          },
          child: Container(
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
                    image: NetworkImage(workoutValue.workout_image_url
                                    .toString()
                                    .substring(0, 4) !=
                                'http'
                            ? '$ip/${workoutValue.workout_image_url}'
                            : workoutValue.workout_image_url.toString()
                        // 'https://media.istockphoto.com/photos/various-sport-equipments-on-grass-picture-id949190756?s=612x612',
                        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                child: Text(workoutValue.name.toString(),
                                    style: TextStyle(
                                        color: blueColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25)),
                              ),
                              FittedBox(
                                child: Text(
                                  'Exercises: ${workoutValue.excersise_count}',
                                  style: theme.textTheme.displaySmall,
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
                                    '${workoutValue.length} min',
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: orangeColor.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FittedBox(
                                child: Text(
                                  ' ',
                                  style: theme.textTheme.displaySmall,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  '${workoutValue.predicted_burnt_calories} Kcal',
                                  style: theme.textTheme.displaySmall,
                                ),
                              ),
                              Icon(
                                Icons.electric_bolt_rounded,
                                color: workoutValue.difficulty == 1
                                    ? Colors.green
                                    : (workoutValue.difficulty == 2
                                        ? Colors.yellow
                                        : Colors.red),
                                size: 25,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
