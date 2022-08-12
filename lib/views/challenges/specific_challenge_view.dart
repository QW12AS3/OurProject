import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/specific_challenge_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';

class SpecificChallenge extends StatefulWidget {
  const SpecificChallenge({Key? key}) : super(key: key);

  @override
  State<SpecificChallenge> createState() => _SpecificChallengeState();
}

class _SpecificChallengeState extends State<SpecificChallenge> {
  Duration countDownDuration = Duration(hours: 1000);
  Duration duration = Duration();
  Timer? timer;

  bool isCountdown = true;

  var argu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      argu = args;
      Provider.of<SpeceficChallengeViewModel>(context, listen: false)
          .getSpecificChallengeData(
              context.locale == Locale('en') ? 'en' : 'ar', argu['id'], 'in');
      print('tapped');
      print(argu['id']);
    });

    // startTimer();
    reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() {
        duration = countDownDuration;
      });
    } else {
      setState(() {
        duration = Duration();
      });
    }
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      print(seconds);
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text(
        'Challenge',
        style: theme.textTheme.bodyMedium!,
      ).tr()),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          // controller: controller,
          child: !Provider.of<SpeceficChallengeViewModel>(context, listen: true)
                  .getchallengesList!
                  .isEmpty
              ? bigLoader(color: orangeColor)
              : Column(
                  children: [
                    Container(
                      // width: mq.size.width * 0.3,
                      // height: mq.size.height * 0.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress != null
                                  ? const LoadingContainer()
                                  : child,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            // 'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                            "$ip/${Provider.of<SpeceficChallengeViewModel>(context).getchallenge.img}",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.size.height * 0.1,
                    ),
                    Provider.of<SpeceficChallengeViewModel>(context)
                                .getchallenge
                                .is_time ??
                            true
                        ? Column(
                            children: [
                              Container(
                                child: buildTime(),
                              ),
                              buildButtons(),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //   children: [
                              //     ElevatedButton(
                              //       onPressed: () {
                              //         if ((timer != null && timer!.isActive)) {
                              //           startTimer();
                              //         } else {
                              //           timer?.cancel();
                              //         }
                              //         print(timer != null && timer!.isActive);
                              //       },
                              //       child: Text(
                              //         (timer != null && timer!.isActive)
                              //             ? 'Finish'.tr()
                              //             : 'Start'.tr(),
                              //       ),
                              //     ),
                              //   ],
                              // )
                              ElevatedButton(
                                  onPressed: () {
                                    print(duration.inMinutes);
                                  },
                                  child: Text('test'))
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              print(duration.inMinutes);
                            },
                            child: Icon(Icons.add_circle_outline))
                  ],
                ),
        ),
      ),
    ));
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'Hours'),
        SizedBox(
          width: 8,
        ),
        buildTimeCard(time: minutes, header: 'Minutes'),
        SizedBox(
          width: 8,
        ),
        buildTimeCard(time: seconds, header: 'Seconds'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: blueColor, borderRadius: BorderRadius.circular(20)),
          child: Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: orangeColor,
              fontSize: 72,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          header.tr(),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: orangeColor,
            fontSize: 20,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? ElevatedButton(
            onPressed: () {
              if (isRunning) {
                stopTimer(resets: false);
              } else {
                startTimer(resets: false);
              }
            },
            child: Text(isRunning ? 'Stop'.tr() : 'Resume'.tr()))
        : ElevatedButton(
            onPressed: () {
              print('yes');
              // startTimer();
              // isRunning = true;
            },
            child: Text('Start'));
    // return isRuning ? ElevatedButton(onPressed: () {}, child: Text('Stop'));
  }
}
