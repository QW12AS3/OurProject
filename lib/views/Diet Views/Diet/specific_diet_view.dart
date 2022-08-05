import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/diet_model.dart';
import 'package:home_workout_app/models/meal_model.dart';
import 'package:home_workout_app/view_models/Diet%20View%20Model/Diet/specific_diet_view_model.dart';
import 'package:provider/provider.dart';

import '../../../view_models/Diet View Model/Meal/meal_list_view_model.dart';
import '../../../view_models/profile_view_model.dart';

class SpecificDietView extends StatefulWidget {
  const SpecificDietView({Key? key}) : super(key: key);

  @override
  State<SpecificDietView> createState() => _SpecificDietViewState();
}

class _SpecificDietViewState extends State<SpecificDietView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;

      Provider.of<SpecificDietViewModel>(context, listen: false).setSpecDiet(
          lang: getLang(context), id: args['dietId'] ?? 0, context: context);
    });
  }

  String mealString = 'Meals:'.tr();
  String kcalString = 'kcal'.tr();
  String dayString = 'Day'.tr();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Consumer<SpecificDietViewModel>(
          builder: (context, diet, child) => Text(
            diet.getDiet.name,
            style: theme.textTheme.bodyMedium!,
          ).tr(),
        ),
      ),
      body: Provider.of<SpecificDietViewModel>(context, listen: true)
              .getIsLoading
          ? bigLoader(color: orangeColor)
          : SingleChildScrollView(
              child: Consumer<SpecificDietViewModel>(
                builder: (context, diet, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Row(
                        children: [
                          Text('Meals: ', style: theme.textTheme.bodySmall)
                              .tr(),
                          Text(
                            diet.getDiet.mealsCount.toString(),
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: greyColor),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 25, vertical: 10),
                    //   child: Row(
                    //     children: [
                    //       Text('Calories: ', style: theme.textTheme.bodySmall)
                    //           .tr(),
                    //       Text(
                    //         '${diet.getDiet.caloriesCount.toString()} $kcalString',
                    //         style: theme.textTheme.bodySmall!
                    //             .copyWith(color: greyColor),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child:
                          Text('Schedule: ', style: theme.textTheme.bodySmall)
                              .tr(),
                    ),
                    ListBody(
                      children: diet.getDiet.meals
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    child: Text(
                                      '$dayString ${e['day']}:',
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(color: blueColor),
                                    ),
                                  ),
                                  Column(
                                      children: e['meals'].map<Widget>((meal) {
                                    final mealData = meal as MealModel;
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: blueColor, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  mealData.type,
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: orangeColor,
                                                          fontSize: 17),
                                                ),
                                                Text(
                                                  '${mealData.calories} $kcalString',
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: orangeColor,
                                                          fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              mealData.description,
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                      color: greyColor,
                                                      fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        subtitle: ExpansionTile(
                                          title: Text(
                                            'Foods',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(color: blueColor),
                                          ),
                                          children: e['foods']
                                              .map<Widget>(
                                                (e) => Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
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
                                                              color:
                                                                  orangeColor,
                                                              fontSize: 17),
                                                    ),
                                                    subtitle: Text(
                                                      '${e.calories} $kcalString',
                                                      style: theme
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              color: greyColor,
                                                              fontSize: 12),
                                                    ),
                                                    leading: CircleAvatar(
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
                                        // trailing:
                                        //     Provider.of<ProfileViewModel>(
                                        //                         context,
                                        //                         listen:
                                        //                             true)
                                        //                     .getUserData
                                        //                     .roleId ==
                                        //                 4 ||
                                        //             Provider.of<ProfileViewModel>(
                                        //                         context,
                                        //                         listen:
                                        //                             true)
                                        //                     .getUserData
                                        //                     .roleId ==
                                        //                 5
                                        //         ? PopupMenuButton(
                                        //             onSelected:
                                        //                 (value) async {
                                        //               switch (value) {
                                        //                 case 'edit':
                                        //                   Navigator.pushNamed(
                                        //                       context,
                                        //                       '/editMeal',
                                        //                       arguments: {
                                        //                         'meal': e
                                        //                       });
                                        //                   break;

                                        //                 case 'delete':
                                        //                   await Provider.of<MealsListViewModel>(
                                        //                           context,
                                        //                           listen:
                                        //                               false)
                                        //                       .deleteMeal(
                                        //                           lang: getLang(
                                        //                               context),
                                        //                           mealId: mealData
                                        //                               .id,
                                        //                           context:
                                        //                               context);
                                        //                   break;
                                        //                 default:
                                        //               }
                                        //             },
                                        //             itemBuilder:
                                        //                 (context) => [
                                        //               PopupMenuItem(
                                        //                   value: 'edit',
                                        //                   child: Text(
                                        //                     'Edit',
                                        //                     style: theme
                                        //                         .textTheme
                                        //                         .bodySmall!
                                        //                         .copyWith(
                                        //                             color:
                                        //                                 blueColor),
                                        //                   ).tr()),
                                        //               PopupMenuItem(
                                        //                   value: 'delete',
                                        //                   child: Text(
                                        //                     'Delete',
                                        //                     style: theme
                                        //                         .textTheme
                                        //                         .bodySmall!
                                        //                         .copyWith(
                                        //                             color:
                                        //                                 Colors.red),
                                        //                   ).tr())
                                        //             ],
                                        //           )
                                        //         : null,
                                      ),
                                    );
                                  }).toList()),
                                  Divider(
                                    indent: 50,
                                    endIndent: 50,
                                    thickness: 1,
                                    color: orangeColor,
                                  )
                                ],
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
