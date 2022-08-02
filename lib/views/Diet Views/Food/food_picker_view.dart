// ignore_for_file: avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Diet%20View%20Model/Food/foods_list_view_model.dart';
import 'package:home_workout_app/view_models/Diet%20View%20Model/Meal/create_meal_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Posts%20View/post_view_widgets.dart';
import 'package:provider/provider.dart';

class FoodsPickerListView extends StatefulWidget {
  const FoodsPickerListView({Key? key}) : super(key: key);

  @override
  State<FoodsPickerListView> createState() => _FoodsPickerListViewState();
}

class _FoodsPickerListViewState extends State<FoodsPickerListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<FoodsListViewModel>(context, listen: false).reset();
      Provider.of<FoodsListViewModel>(context, listen: false)
          .getFoods(lang: getLang(context));

      _scrollController.addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          Provider.of<FoodsListViewModel>(context, listen: false)
              .getFoods(lang: getLang(context));
        }
      });
    });
  }

  TextEditingController _searchController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  String kcalString = 'kcal'.tr();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Foods list',
          style: theme.textTheme.bodyMedium!,
        ).tr(),
      ),
      body: Consumer2<FoodsListViewModel, CreateMealViewModel>(
        builder: (context, food, meal, child) => RefreshIndicator(
            color: orangeColor,
            onRefresh: () async {
              food.reset();
              food..getFoods(lang: getLang(context));
            },
            child: food.getIsLoading
                ? Center(
                    child: bigLoader(color: orangeColor),
                  )
                : (food.getFoodsList.isEmpty
                    ? Center(
                        child: Text('There are no foods',
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: greyColor))
                            .tr(),
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
                                    children: food.getFoodsList
                                        .where((element) => _searchController
                                                .text
                                                .trim()
                                                .isEmpty
                                            ? true
                                            : element.name.contains(
                                                _searchController.text.trim()))
                                        .map(
                                          (e) => InkWell(
                                            onTap: () {
                                              if (meal.getPickedFoods
                                                  .contains(e.id))
                                                meal.removeFromFoods(e.id);
                                              else
                                                meal.addToFoods(e.id);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: meal.getPickedFoods
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
                                                  e.name,
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: orangeColor,
                                                          fontSize: 17),
                                                ),
                                                subtitle: Text(
                                                  e.description,
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: greyColor,
                                                          fontSize: 12),
                                                ),
                                                leading: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: NetworkImage(
                                                      'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
                                                      //e.imageUrl,
                                                      ),
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
                      ))),
      ),
    );
  }
}
