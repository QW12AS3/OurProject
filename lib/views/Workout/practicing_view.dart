// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/models/workout2_model.dart';
import 'package:home_workout_app/view_models/Workout_View_Model/practicing_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../view_models/Workout_View_Model/specific_workout_view_model.dart';
import '../Home View/home_view_widgets.dart';

class PracticingView extends StatefulWidget {
  PracticingView({Key? key}) : super(key: key);

  @override
  State<PracticingView> createState() => _PracticingViewState();
}

class _PracticingViewState extends State<PracticingView> {
  static const countdownDuration = Duration(seconds: 1);
  Duration duration = Duration();
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(duration, (timer) {});
    timer!.cancel();
    Future.delayed(Duration.zero).then((value) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        workout = args['workout'] as Workout2Model;
      });
      Provider.of<PracticingViewModel>(context, listen: false).reset();
      Provider.of<PracticingViewModel>(context, listen: false)
          .startPractice(lang: getLang(context), id: workout.id);

      // Timer.periodic(const Duration(seconds: 1), (timer) {
      //   if (timer.tick <
      //           workout
      //               .exercises[
      //                   Provider.of<PracticingViewModel>(context, listen: false)
      //                       .getCurrentExerciseIndex]
      //               .length &&
      //       workout
      //               .exercises[
      //                   Provider.of<PracticingViewModel>(context, listen: false)
      //                       .getCurrentExerciseIndex]
      //               .length !=
      //           0)
      //     Provider.of<PracticingViewModel>(context, listen: false)
      //         .setTimer(timer.tick);
      // });
    });
  }

  String reps = 'reps'.trim();
  String sec = 'sec'.trim();

  Workout2Model workout = Workout2Model();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: Consumer<PracticingViewModel>(
        builder: (context, practice, child) => FloatingActionButton(
          onPressed: () {
            _pageController.animateTo(
                practice.getCurrentExerciseIndex.toDouble() + 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);

            if (practice.getCurrentExerciseIndex < workout.exercises.length - 1)
              practice.setCurrentExerciseIndex(
                  practice.getCurrentExerciseIndex + 1);
          },
          child: const Text('Next'),
        ),
      ),
      bottomNavigationBar: Consumer<PracticingViewModel>(
        builder: (context, practice, child) => workout
                        .exercises[practice.getCurrentExerciseIndex].length !=
                    0 &&
                practice.getIsPlaying
            ? Text('')
            : TextButton(
                onPressed: () {
                  practice.setIsPlaying(practice.getIsPlaying ? false : true);

                  if (workout
                          .exercises[practice.getCurrentExerciseIndex].count !=
                      0) {
                    if (practice.getIsPlaying) {
                      log('Started');
                      timer = Timer.periodic(countdownDuration, (timer) {
                        practice.setTimer(timer.tick);
                      });
                    } else {
                      log('Finished');
                      timer!.cancel();
                      practice.setTimer(0);
                      timer = Timer.periodic(duration, (timer) {});
                      practice.setTimer(0);
                      _pageController.animateTo(
                          practice.getCurrentExerciseIndex.toDouble() + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    }
                  } else {
                    if (practice.getIsPlaying) {
                      log('Started');
                      timer = Timer.periodic(countdownDuration, (timer) {
                        if (timer.tick >=
                            workout.exercises[practice.getCurrentExerciseIndex]
                                .length) {
                          practice.setIsPlaying(false);
                          timer.cancel();
                          timer = Timer.periodic(duration, (timer) {});
                          practice.setTimer(0);
                          _pageController.animateTo(
                              practice.getCurrentExerciseIndex.toDouble() + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear);
                        }
                        practice.setTimer(timer.tick);
                      });
                    } else {
                      log('Finished');
                      timer!.cancel();
                      practice.setTimer(0);
                    }
                  }
                },
                child: Text(
                  practice.getIsPlaying ? 'Finish' : 'Start',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
      ),
      appBar: AppBar(
        title: Consumer<PracticingViewModel>(
          builder: (context, practice, child) => Text(
            workout.exercises.isNotEmpty
                ? workout.exercises[practice.getCurrentExerciseIndex].name
                : '0',
            style: theme.textTheme.bodyMedium!.copyWith(color: blueColor),
          ).tr(),
        ),
      ),
      body: Consumer<PracticingViewModel>(
        builder: (context, practice, child) => (practice.getIsLoading ||
                workout.exercises.isEmpty)
            ? Center(
                child: bigLoader(color: orangeColor),
              )
            : PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        try {
                          return Image(
                            errorBuilder: (context, error, stackTrace) =>
                                const LoadingContainer(),
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress != null
                                    ? const LoadingContainer()
                                    : child,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(workout.exercises[index].imgUrl),
                          );
                        } catch (e) {
                          return const LoadingContainer();
                        }
                      },
                    ),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      color: blueColor,
                    ),
                    if (workout.exercises[practice.getCurrentExerciseIndex]
                            .length !=
                        0)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${workout.exercises[practice.getCurrentExerciseIndex].length} $sec'),
                        ),
                      )
                    else
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // ignore: prefer_interpolation_to_compose_strings
                          child: Text(
                              '${workout.exercises[practice.getCurrentExerciseIndex].count.toString()} $reps'),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: mq.size.width * 0.25),
                      child: Text(
                        '${practice.getTimer} $sec',
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
