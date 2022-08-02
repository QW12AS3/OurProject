import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/views/Posts%20View/post_view_widgets.dart';
import 'package:provider/provider.dart';

import '../../../view_models/Diet View Model/Diet/create_diet_view_model.dart';
import '../../../view_models/Diet View Model/Meal/meal_list_view_model.dart';

class CreateDietView extends StatefulWidget {
  const CreateDietView({Key? key}) : super(key: key);

  @override
  State<CreateDietView> createState() => _CreateDietViewState();
}

class _CreateDietViewState extends State<CreateDietView> {
  TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Create diet',
          style: theme.textTheme.bodyMedium!,
        ).tr(),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                  maxLines: 1, controller: _nameController, title: 'Diet name'),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mealPicker');
              },
              child: Text(
                '+ Add meals',
                style: theme.textTheme.bodySmall,
              ).tr()),

          // Consumer2<CreateDietViewModel,MealsListViewModel>(
          // builder:(context, diet, meal, child) => meal.getMealsList.where((element) => diet.getBreakfastMeals.contains(element.id)||diet.getDinnerMeals.contains(element.id)||diet.getLunchMeals.contains(element.id)||diet.getSnacksMeals.contains(element.id)).map((e) => Text('')
          //                                       )
          //                                       .toList(),
          //                                 ),

          //                             ),).toList()
        ],
      )),
    );
  }
}
