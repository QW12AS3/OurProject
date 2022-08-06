// ignore_for_file: avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Workout_View_Model/create_workout_view_model.dart';
import 'package:home_workout_app/views/Posts%20View/post_view_widgets.dart';
import 'package:provider/provider.dart';

class ExercisePickerListView extends StatefulWidget {
  const ExercisePickerListView({Key? key}) : super(key: key);

  @override
  State<ExercisePickerListView> createState() => _ExercisePickerListViewState();
}

class _ExercisePickerListViewState extends State<ExercisePickerListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<CreateworkoutViewModel>(context, listen: false).reset();
      Provider.of<CreateworkoutViewModel>(context, listen: false)
          .getExercisesData(getLang(context));
      print('fffffffff]]]]]]]]');
      print(Provider.of<CreateworkoutViewModel>(context, listen: false)
          .getIsFetched);
    });
  }

  TextEditingController _searchController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  // String kcalString = 'kcal'.tr();

  List<int> exercisesId = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, exercisesId);
          return false;
        },
        child: Scaffold(
          bottomNavigationBar: SizedBox(
            height: 30,
            child: Center(
              child: Text(
                'Press back button when finished',
                style: theme.textTheme.bodySmall!.copyWith(color: greyColor),
              ).tr(),
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, exercisesId);
              },
              icon: Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Exercises list',
              style: theme.textTheme.bodyMedium!,
            ).tr(),
          ),
          body: Consumer<CreateworkoutViewModel>(
            builder: ((context, value, _) => RefreshIndicator(
                color: orangeColor,
                onRefresh: () async {
                  value.reset();
                  value.getExercisesData(getLang(context));
                  print('fffffffff]]]]]]]]');
                  print(Provider.of<CreateworkoutViewModel>(context,
                          listen: false)
                      .fetchedExercisesList);
                },
                child: !Provider.of<CreateworkoutViewModel>(context,
                            listen: true)
                        .fetchedExercisesList
                    ? Center(
                        child: bigLoader(color: orangeColor),
                      )
                    : ((value.ConvertedFutureExercisesList == null ||
                            value.ConvertedFutureExercisesList!.isEmpty)
                        ? Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('There are no Exercise',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(color: greyColor))
                                    .tr(),
                                TextButton(
                                    onPressed: () async {
                                      value.reset();
                                      value.getExercisesData(getLang(context));
                                    },
                                    child: Text('Refresh',
                                            style: theme.textTheme.bodySmall)
                                        .tr())
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                    maxLines: 1,
                                    controller: _searchController,
                                    title: 'Search'),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  controller: _scrollController,
                                  child: Column(
                                    children: [
                                      Column(
                                        children: value.exercisesList!
                                            .where((element) =>
                                                _searchController.text
                                                        .trim()
                                                        .isEmpty
                                                    ? true
                                                    : element.name!.contains(
                                                        _searchController.text
                                                            .trim()))
                                            .map(
                                              (e) => InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (!exercisesId
                                                        .contains(e.id)) {
                                                      exercisesId
                                                          .add(e.id!.toInt());
                                                    } else {
                                                      exercisesId.removeWhere(
                                                          (element) =>
                                                              element == e.id);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: exercisesId
                                                              .contains(e.id)
                                                          ? blueColor
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          color: blueColor,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: ListTile(
                                                    title: Text(
                                                      e.name.toString(),
                                                      style: theme
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              color:
                                                                  orangeColor,
                                                              fontSize: 17),
                                                    ),
                                                    subtitle: Text(
                                                      e.desc.toString(),
                                                      style: theme
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              color: greyColor,
                                                              fontSize: 12),
                                                    ),
                                                    leading: CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage: NetworkImage(e
                                                                  .exercise_img
                                                                  .toString()
                                                                  .substring(
                                                                      0, 4) !=
                                                              'http'
                                                          ? '$ip/${e.exercise_img}'
                                                          : e.exercise_img
                                                              .toString()),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )))),
          ),
        ));
  }
}