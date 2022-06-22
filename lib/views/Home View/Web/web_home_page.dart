import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/web_home_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 2,
            mainAxisExtent: 2,
            mainAxisSpacing: 10,
            childAspectRatio: 5 / 2),
        itemBuilder: (BuildContext context, int index) =>
            Consumer<WebHomeViewModel>(
              builder: (context, value, child) => workoutCard(
                publisherName: value.getWorkouts()[index].publisherName,
                imageUrl: value.getWorkouts()[index].imageUrl,
                exercisesNum: value.getWorkouts()[index].excersises,
                min: value.getWorkouts()[index].excpectedTime,
                publisherImageUrl: value.getWorkouts()[index].imageUrl,
                workoutName: value.getWorkouts()[index].name,
              ),
            ));
    // Column(
    //   children: [
    //     Consumer<WebHomeViewModel>(
    //       builder: (context, value, child) => DropdownButton(
    //         elevation: 20,
    //         underline: const SizedBox(),
    //         focusColor: Colors.transparent,
    //         iconEnabledColor: blueColor,
    //         iconDisabledColor: blueColor,
    //         borderRadius: BorderRadius.circular(25),
    //         value: value.selectedCategorie,
    //         items: value.categories.entries
    //             .map(
    //               (e) => DropdownMenuItem(
    //                 value: e.key,
    //                 child: Container(
    //                   margin: const EdgeInsets.all(4),
    //                   padding: const EdgeInsets.all(7),
    //                   decoration: BoxDecoration(
    //                       color: blueColor,
    //                       borderRadius: BorderRadius.circular(15)),
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(4),
    //                     child: Text(
    //                       e.key,
    //                       style: theme.textTheme.bodySmall!.copyWith(
    //                           color: Colors.white, fontSize: e.value ? 15 : 10),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             )
    //             .toList(),
    //         onChanged: (String? newCategorie) {
    //           value.changeSelectedCategorie(newCategorie ?? 'Recommended');
    //         },
    //       ),
    //     ),

    //   ],
    // );
  }
}
