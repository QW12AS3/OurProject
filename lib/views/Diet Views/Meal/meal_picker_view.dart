// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Diet%20View%20Model/Diet/create_diet_view_model.dart';
import 'package:home_workout_app/view_models/Diet%20View%20Model/Food/foods_list_view_model.dart';
import 'package:home_workout_app/view_models/Diet%20View%20Model/Meal/meal_list_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Posts%20View/post_view_widgets.dart';
import 'package:provider/provider.dart';

class MealPickerView extends StatefulWidget {
  const MealPickerView({Key? key}) : super(key: key);

  @override
  State<MealPickerView> createState() => _MealPickerViewState();
}

class _MealPickerViewState extends State<MealPickerView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<MealsListViewModel>(context, listen: false).reset();
      Provider.of<MealsListViewModel>(context, listen: false)
          .getMeals(lang: getLang(context));

      _searchController.addListener(() {
        if (_searchController.text.trim() != searchValue)
          // ignore: curly_braces_in_flow_control_structures
          setState(() {
            searchValue = _searchController.text.trim();
          });
      });

      _scrollController.addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          Provider.of<MealsListViewModel>(context, listen: false)
              .getMeals(lang: getLang(context));
        }
      });
    });
  }

  String searchValue = '';
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
          'Meals list',
          style: theme.textTheme.bodyMedium!,
        ).tr(),
      ),
      body: Consumer<MealsListViewModel>(
        builder: (context, food, child) => RefreshIndicator(
            color: orangeColor,
            onRefresh: () async {
              Provider.of<MealsListViewModel>(context, listen: false).reset();
              await Provider.of<MealsListViewModel>(context, listen: false)
                  .getMeals(lang: getLang(context));
            },
            child: food.getIsLoading
                ? Center(
                    child: bigLoader(color: orangeColor),
                  )
                : (food.getMealsList.isEmpty
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('There are no meals',
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(color: greyColor))
                                .tr(),
                            TextButton(
                                onPressed: () async {
                                  Provider.of<MealsListViewModel>(context,
                                          listen: false)
                                      .reset();
                                  await Provider.of<MealsListViewModel>(context,
                                          listen: false)
                                      .getMeals(lang: getLang(context));
                                },
                                child: Text('Refresh',
                                    style: theme.textTheme.bodySmall))
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
                                    children: food.getMealsList
                                        .where((element) => element.type
                                                    .contains(_searchController
                                                        .text
                                                        .trim()) ||
                                                element.foods
                                                    .where((element) =>
                                                        element.name.contains(
                                                            _searchController
                                                                .text
                                                                .trim()))
                                                    .isNotEmpty
                                            ? true
                                            : false)
                                        .map(
                                          (e) => Consumer<CreateDietViewModel>(
                                            builder: (context, diet, child) =>
                                                InkWell(
                                              onTap: () {
                                                if (diet.getBreakfastMeals
                                                        .contains(e.id) ||
                                                    diet.getDinnerMeals
                                                        .contains(e.id) ||
                                                    diet.getLunchMeals
                                                        .contains(e.id) ||
                                                    diet.getSnacksMeals
                                                        .contains(e.id))
                                                  diet.removeFromMeals(
                                                      e.id, e.type);
                                                else
                                                  diet.addToMeals(e.id, e.type);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                margin: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: (diet.getBreakfastMeals
                                                                .contains(
                                                                    e.id) ||
                                                            diet.getDinnerMeals
                                                                .contains(
                                                                    e.id) ||
                                                            diet.getLunchMeals
                                                                .contains(
                                                                    e.id) ||
                                                            diet.getSnacksMeals
                                                                .contains(e.id))
                                                        ? blueColor
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                        color: blueColor,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: ListTile(
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            e.type,
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color:
                                                                        orangeColor,
                                                                    fontSize:
                                                                        17),
                                                          ),
                                                          Text(
                                                            '${e.calories} $kcalString',
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color:
                                                                        orangeColor,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        e.description,
                                                        style: theme.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color:
                                                                    greyColor,
                                                                fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: ExpansionTile(
                                                    title: Text(
                                                      'Foods',
                                                      style: theme.textTheme.bodySmall!.copyWith(
                                                          color: (diet.getBreakfastMeals.contains(e.id) ||
                                                                  diet.getDinnerMeals
                                                                      .contains(e
                                                                          .id) ||
                                                                  diet.getLunchMeals
                                                                      .contains(e
                                                                          .id) ||
                                                                  diet.getSnacksMeals
                                                                      .contains(
                                                                          e.id))
                                                              ? orangeColor
                                                              : blueColor),
                                                    ),
                                                    children: e.foods
                                                        .map(
                                                          (e) => Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                        blueColor,
                                                                    width: 1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: ListTile(
                                                              title: Text(
                                                                e.name,
                                                                style: theme
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color:
                                                                            orangeColor,
                                                                        fontSize:
                                                                            17),
                                                              ),
                                                              subtitle: Text(
                                                                '${e.calories} $kcalString',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color:
                                                                            greyColor,
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                              leading:
                                                                  CircleAvatar(
                                                                radius: 50,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        e.imageUrl),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                  trailing:
                                                      Provider.of<ProfileViewModel>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .getUserData
                                                                  .id ==
                                                              e.ownerId
                                                          ? PopupMenuButton(
                                                              onSelected:
                                                                  (value) async {
                                                                switch (value) {
                                                                  case 'edit':
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/editMeal',
                                                                        arguments: {
                                                                          'meal':
                                                                              e
                                                                        });
                                                                    break;

                                                                  case 'delete':
                                                                    await Provider.of<MealsListViewModel>(context, listen: false).deleteMeal(
                                                                        lang: getLang(
                                                                            context),
                                                                        mealId: e
                                                                            .id,
                                                                        context:
                                                                            context);
                                                                    break;
                                                                  default:
                                                                }
                                                              },
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem(
                                                                    value:
                                                                        'edit',
                                                                    child: Text(
                                                                      'Edit',
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                              color: blueColor),
                                                                    ).tr()),
                                                                PopupMenuItem(
                                                                    value:
                                                                        'delete',
                                                                    child: Text(
                                                                      'Delete',
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                              color: Colors.red),
                                                                    ).tr())
                                                              ],
                                                            )
                                                          : null,
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
