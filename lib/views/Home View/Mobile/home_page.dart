import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          primary: false,
          flexibleSpace: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: orangeColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: blueColor, width: 1.5),
                ),
                margin: const EdgeInsets.only(
                    right: 15, left: 15, top: 15, bottom: 0),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text('Your short summmary: ',
                          style: theme.textTheme.bodySmall),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSummaryRow(
                                title1: 'Calories Burned: ',
                                title2: '2500 kcal'),
                            const SizedBox(
                              height: 8,
                            ),
                            buildSummaryRow(
                                title1: 'Workouts finished: ', title2: '5'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSummaryRow(title1: 'BMI: ', title2: 'Normal'),
                            const SizedBox(
                              height: 8,
                            ),
                            buildSummaryRow(
                                title1: 'Weight: ', title2: '75 kg'),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          toolbarHeight: 250,
          floating: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([]),
        )
      ],
    );
  }
}
