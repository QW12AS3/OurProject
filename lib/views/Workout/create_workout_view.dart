import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
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
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // futurechallengesList = GeneralChallengesViewModel().getData('en', 1);
    // print(futurechallengesList);
    Future.delayed(Duration.zero).then((value) async {
      // Provider.of<CreateworkoutViewModel>(context, listen: false).reset();
      if (Provider.of<CreateworkoutViewModel>(context, listen: false)
              .fetchedList ==
          false)
        futurechallengesList =
            Provider.of<CreateworkoutViewModel>(context, listen: false)
                .getData(context.locale == Locale('en') ? 'en' : 'ar', 0);
      print(Provider.of<CreateworkoutViewModel>(context, listen: false)
              .fetchedList ==
          false);
      // List data = jsonDecode(response.body)['data'] ?? [];

      // print(Provider.of<CreateworkoutViewModel>(context, listen: false).getChallengesList(lang));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Provider.of<CreateworkoutViewModel>(context, listen: false).reset();
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
        title: Text(
          'Create workout',
          style: theme.textTheme.bodyMedium!,
        ),
      ),
      body: Provider.of<CreateworkoutViewModel>(context).fetchedList == true
          ? SafeArea(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: SingleChildScrollView(
                    // controller: controller,
                    child: Column(children: [
                      Form(
                          key: formGlobalKey,
                          child: Column(children: [
                            SizedBox(
                              height: mq.size.height * 0.02,
                            ),
                            Container(
                              width: mq.size.width * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.white70.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  return CreateworkoutViewModel().checkName(
                                      value.toString(),
                                      context.locale == Locale('en')
                                          ? 'en'
                                          : 'ar');
                                },
                                decoration: InputDecoration(
                                  // focusedErrorBorder:  OutlineInputBorder(
                                  //   borderSide:
                                  //       BorderSide(color: blueColor, width: 1.5),
                                  //   borderRadius: BorderRadius.all(
                                  //     Radius.circular(15),
                                  //   ),
                                  // ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greyColor, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.5),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: orangeColor, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  labelText: 'Name'.tr(),
                                  labelStyle: TextStyle(
                                      color: orangeColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(
                                    CupertinoIcons
                                        .textformat_abc_dottedunderline,
                                    color: blueColor,
                                    size: 33,
                                  ),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                style: TextStyle(
                                    color: blueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                // maxLines: 5,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ])),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Select category's name: "),
                          ),
                          DropdownButton<String>(
                            value: Provider.of<CreateworkoutViewModel>(context,
                                    listen: false)
                                .dropDownNewValue,
                            icon: Icon(Icons.arrow_downward, color: blueColor),
                            elevation: 16,
                            style: TextStyle(color: blueColor),
                            underline: Container(
                              height: 2,
                              color: blueColor,
                            ),
                            onChanged: (String? newValue) {
                              Provider.of<CreateworkoutViewModel>(context,
                                      listen: false)
                                  .setdropDownNewValue(newValue!);
                            },
                            items: Provider.of<CreateworkoutViewModel>(context)
                                .dropDownList
                                ?.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          /*  DropdownButton(
                              value: selectedDropDownValue,
                              items: dropDownList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                selectedDropDownValue = newValue!;
                              }
                              ),*/
                        ],
                      ),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Select equipment: "),
                          ),
                          DropdownButton<String>(
                            value: Provider.of<CreateworkoutViewModel>(context,
                                    listen: false)
                                .equipmentDropDownNewValue,
                            icon: Icon(Icons.arrow_downward, color: blueColor),
                            elevation: 16,
                            style: TextStyle(color: blueColor),
                            underline: Container(
                              height: 2,
                              color: blueColor,
                            ),
                            onChanged: (String? newValue) {
                              Provider.of<CreateworkoutViewModel>(context,
                                      listen: false)
                                  .setequipmentDropDownNewValue(newValue!);
                            },
                            items: Provider.of<CreateworkoutViewModel>(context)
                                .equipmentDropDownList
                                ?.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          /*  DropdownButton(
                              value: selectedDropDownValue,
                              items: dropDownList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                selectedDropDownValue = newValue!;
                              }
                              ),*/
                        ],
                      ),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Select difficulty: "),
                          ),
                          DropdownButton<String>(
                            value: Provider.of<CreateworkoutViewModel>(context,
                                    listen: false)
                                .difficultyDropDownNewValue,
                            icon: Icon(Icons.arrow_downward, color: blueColor),
                            elevation: 16,
                            style: TextStyle(color: blueColor),
                            underline: Container(
                              height: 2,
                              color: blueColor,
                            ),
                            onChanged: (String? newValue) {
                              Provider.of<CreateworkoutViewModel>(context,
                                      listen: false)
                                  .setdifficultyDropDownNewValue(newValue!);
                            },
                            items: Provider.of<CreateworkoutViewModel>(context)
                                .difficultyDropDownList
                                ?.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          /*  DropdownButton(
                              value: selectedDropDownValue,
                              items: dropDownList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                selectedDropDownValue = newValue!;
                              }
                              ),*/
                        ],
                      ),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              onPressed: () async {
                                final mealsId = await Navigator.pushNamed(
                                    context, '/exercisesPicker') as List;
                                mealsId.forEach((element) {
                                  Provider.of<CreateworkoutViewModel>(context,
                                          listen: false)
                                      .addToExercises(element);
                                });
                                print(Provider.of<CreateworkoutViewModel>(
                                        context,
                                        listen: false)
                                    .fetchedList);
                              },
                              child: Text(
                                '+ Add Exercises',
                                style: theme.textTheme.bodySmall,
                              ).tr()),
                        ),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                      //          Consumer<CreateworkoutViewModel>(
                      // builder: ((context, value, _) => value.pickedExercisesIDs.isEmpty
                      //       ? const Text('')
                      //       : ListBody(
                      //           children: value.pickedExercisesIDs
                      //               .where((element) =>
                      //                   value.pickedExercisesIDs.contains(element.id))
                      //               .map(
                      //                 (e) => Dismissible(
                      //                   key: Key(e.id.toString()),
                      //                   onDismissed: (direction) {
                      //                     (e.id);
                      //                   },
                      //                   child: Container(
                      //                     padding: const EdgeInsets.all(8),
                      //                     margin: const EdgeInsets.all(8),
                      //                     decoration: BoxDecoration(
                      //                         border:
                      //                             Border.all(color: blueColor, width: 1),
                      //                         borderRadius: BorderRadius.circular(15)),
                      //                     child: ListTile(
                      //                       title: Text(
                      //                         e.name,
                      //                         style: theme.textTheme.bodySmall!.copyWith(
                      //                             color: orangeColor, fontSize: 17),
                      //                       ),
                      //                       subtitle: Text(
                      //                         '${e.} ',
                      //                         style: theme.textTheme.bodySmall!.copyWith(
                      //                             color: greyColor, fontSize: 12),
                      //                       ),
                      //                       leading: CircleAvatar(
                      //                         radius: 50,
                      //                         backgroundImage: NetworkImage(
                      //                           e.,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )
                      //               .toList(),
                      //         )
                      // ),)
                      ElevatedButton(
                          onPressed: () async {
                            if (formGlobalKey.currentState!.validate()) {
                              formGlobalKey.currentState!.save();
                              final CreateworkoutModel BackEndMessage =
                                  await CreateworkoutViewModel()
                                      .postWorkoutInfo(
                                          nameController.text,
                                          Provider.of<CreateworkoutViewModel>(
                                                  context,
                                                  listen: false)
                                              .dropDownNewValue,
                                          Provider.of<CreateworkoutViewModel>(
                                                  context,
                                                  listen: false)
                                              .equipmentDropDownNewValue
                                              .toString(),
                                          Provider.of<CreateworkoutViewModel>(
                                                  context,
                                                  listen: false)
                                              .getIdOfDifficultyDropDownValue(),
                                          [''],
                                          context.locale == Locale('en')
                                              ? 'en'
                                              : 'ar');
                              print('ffffffffffssssssssssss');
                              print(BackEndMessage.statusCode);
                              print(BackEndMessage.message);
                              if (BackEndMessage.message != null &&
                                  BackEndMessage.message != '') {
                                showSnackbar(
                                    Text(BackEndMessage.message.toString()),
                                    context);
                              }
                              if (BackEndMessage.statusCode == 201) {
                                nameController.clear();

                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: Text('Save')),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                    ]),
                  ),
                ),
              ),
            )
          : CustomLoading(),
    );
  }
}
