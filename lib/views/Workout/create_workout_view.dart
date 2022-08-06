import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:home_workout_app/models/create_workout_model.dart';
import 'package:home_workout_app/view_models/Workout_View_Model/create_workout_view_model.dart';
import 'package:provider/provider.dart';

class CreateWorkoutView extends StatefulWidget {
  const CreateWorkoutView({Key? key}) : super(key: key);

  @override
  State<CreateWorkoutView> createState() => _CreateWorkoutViewState();
}

class _CreateWorkoutViewState extends State<CreateWorkoutView> {
  Future<List<CreateworkoutModel>>? futurechallengesList;
  @override
  void initState() {
    super.initState();
    // futurechallengesList = GeneralChallengesViewModel().getData('en', 1);
    // print(futurechallengesList);
    Future.delayed(Duration.zero).then((value) async {
      futurechallengesList =
          Provider.of<CreateworkoutViewModel>(context, listen: false)
              .getData(context.locale == Locale('en') ? 'en' : 'ar', 0);

      // List data = jsonDecode(response.body)['data'] ?? [];

      // print(Provider.of<CreateChallengesViewModel>(context, listen: false).getChallengesList(lang));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.white,
      child: SingleChildScrollView(
        // controller: controller,
        child: Column(
            // children: [ElevatedButton(onPressed: () {}, child: Text('a'))],
            ),
      ),
    ));
  }
}
