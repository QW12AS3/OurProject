import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Diet%20View%20Model/Diet/diet_list_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<DietListViewModel>(context, listen: false)
          .getDietsList(lang: getLang(context));
    });
  }

  String mealString = 'Meals:'.tr();
  String kcalString = 'kcal'.tr();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Provider.of<DietListViewModel>(context).getIsLoading
        ? bigLoader(color: orangeColor)
        : RefreshIndicator(
            color: orangeColor,
            onRefresh: () async {
              await Provider.of<DietListViewModel>(context, listen: false)
                  .getDietsList(lang: getLang(context));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Consumer<DietListViewModel>(
                builder: (context, diet, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: diet.getDiets
                      .map((e) => InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/specDiet',
                                  arguments: {'dietId': e.id});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: blueColor, width: 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      trailing: Provider.of<DietListViewModel>(
                                                  context,
                                                  listen: true)
                                              .getIsDeleteLoading
                                          ? bigLoader(color: orangeColor)
                                          : PopupMenuButton(
                                              onSelected: (value) async {
                                                switch (value) {
                                                  case 'edit':
                                                    Navigator.pushNamed(
                                                        context, '/editDiet',
                                                        arguments: {
                                                          'dietId': e.id,
                                                          'diet': e
                                                        });
                                                    break;

                                                  case 'save':
                                                    break;

                                                  case 'delete':
                                                    await Provider.of<
                                                                DietListViewModel>(
                                                            context,
                                                            listen: false)
                                                        .deleteDiet(
                                                            lang: getLang(
                                                                context),
                                                            id: e.id,
                                                            context: context);
                                                    break;
                                                  default:
                                                }
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    value: 'save',
                                                    child: Text(
                                                      'Save',
                                                      style: theme
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              color: blueColor),
                                                    ).tr()),
                                                if (Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        4 ||
                                                    Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        5 ||
                                                    Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        e.userId)
                                                  PopupMenuItem(
                                                      value: 'edit',
                                                      child: Text(
                                                        'Edit',
                                                        style: theme.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color:
                                                                    blueColor),
                                                      ).tr()),
                                                if (Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        4 ||
                                                    Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        5 ||
                                                    Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        e.userId)
                                                  PopupMenuItem(
                                                      value: 'delete',
                                                      child: Text(
                                                        'Delete',
                                                        style: theme.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
                                                      ).tr())
                                              ],
                                            ),
                                      title: Text(
                                        '${e.userFname} ${e.userLname}',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(color: orangeColor),
                                      ),
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(e.userImg),
                                      ),
                                      subtitle: Text(
                                        e.createAt,
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
                                                color: greyColor, fontSize: 10),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      child: Text(
                                        e.name,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      child: Row(
                                        children: [
                                          Text('Meals: ',
                                                  style:
                                                      theme.textTheme.bodySmall)
                                              .tr(),
                                          Text(
                                            e.mealsCount.toString(),
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(color: greyColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      child: Row(
                                        children: [
                                          Text('Calories: ',
                                                  style:
                                                      theme.textTheme.bodySmall)
                                              .tr(),
                                          Text(
                                            '${e.caloriesCount.toString()} $kcalString',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(color: greyColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          );
  }
}
