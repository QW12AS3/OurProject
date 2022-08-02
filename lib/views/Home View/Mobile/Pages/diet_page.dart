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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Consumer<DietListViewModel>(
        builder: (context, diet, child) => Column(
          children: diet.getDiets
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: blueColor, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            trailing: Provider.of<ProfileViewModel>(context,
                                                listen: true)
                                            .getUserData
                                            .roleId ==
                                        4 ||
                                    Provider.of<ProfileViewModel>(context,
                                                listen: true)
                                            .getUserData
                                            .roleId ==
                                        5 ||
                                    Provider.of<ProfileViewModel>(context,
                                                listen: true)
                                            .getUserData
                                            .roleId ==
                                        e.userId
                                ? PopupMenuButton(
                                    onSelected: (value) async {
                                      switch (value) {
                                        case 'edit':
                                          break;

                                        case 'delete':
                                          break;
                                        default:
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                          value: 'edit',
                                          child: Text(
                                            'Edit',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(color: blueColor),
                                          ).tr()),
                                      PopupMenuItem(
                                          value: 'delete',
                                          child: Text(
                                            'Delete',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(color: Colors.red),
                                          ).tr())
                                    ],
                                  )
                                : null,
                            title: Text(
                              '${e.userFname} ${e.userLname}',
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: orangeColor),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(e.userImg),
                            ),
                            subtitle: Text(
                              e.createAt,
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: greyColor, fontSize: 10),
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
                            child: Text(
                              '$mealString ${e.meals}',
                              style: theme.textTheme.bodyMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
