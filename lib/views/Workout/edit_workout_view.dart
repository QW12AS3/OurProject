import 'dart:io';

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
import 'package:home_workout_app/view_models/Workout_View_Model/edit_workout_view_model.dart';
import 'package:home_workout_app/view_models/exercise_list_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditWorkoutView extends StatefulWidget {
  const EditWorkoutView({Key? key}) : super(key: key);

  @override
  State<EditWorkoutView> createState() => _EditWorkoutViewState();
}

class _EditWorkoutViewState extends State<EditWorkoutView> {
  // Future<List<CreateworkoutModel>>? futurechallengesList;
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  var argu; //isthe main
  @override
  void initState() {
    super.initState();
    // futurechallengesList = GeneralChallengesViewModel().getData('en', 1);
    // print(futurechallengesList);
    Future.delayed(Duration.zero).then((value) async {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      argu = args;
      setState(() {
        // nameController.text = args['burn calories'] ?? '';
        nameController.text = args['name'] ?? '';
        // descriptionController.text = args['description'] ?? '';
      });
      Provider.of<EditworkoutViewModel>(context, listen: false).reset();
      argu['Categories IDs'].forEach((element) {
        Provider.of<EditworkoutViewModel>(context, listen: false)
            .addToExercises(element);
      });
      Provider.of<EditworkoutViewModel>(context, listen: false)
          .setdropDownNewValue(argu['Categories']);
      Provider.of<EditworkoutViewModel>(context, listen: false)
          .setequipmentDropDownNewValue(argu['Equipment']);
      Provider.of<EditworkoutViewModel>(context, listen: false)
          .setdifficultyDropDownNewValue(argu['Difficulty']);
      if (Provider.of<EditworkoutViewModel>(context, listen: false)
              .fetchedList ==
          false)
        // futurechallengesList =
        Provider.of<EditworkoutViewModel>(context, listen: false)
            .getData(context.locale == Locale('en') ? 'en' : 'ar', 0);
      print(Provider.of<EditworkoutViewModel>(context, listen: false)
              .fetchedList ==
          false);
      // List data = jsonDecode(response.body)['data'] ?? [];

      // print(Provider.of<EditworkoutViewModel>(context, listen: false).getChallengesList(lang));
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
        //     Provider.of<EditworkoutViewModel>(context, listen: false).reset();
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
        title: Text(
          'Edit workout',
          style: theme.textTheme.bodyMedium!,
        ),
      ),
      body: Provider.of<EditworkoutViewModel>(context).fetchedList == true
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
                                  return EditworkoutViewModel().checkName(
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
                                  LengthLimitingTextInputFormatter(40),
                                ],
                                style: TextStyle(
                                    color: blueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                // maxLines: 5,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ])),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Select category's name: "),
                              ],
                            ),
                          ),
                          DropdownButton<String>(
                            value: Provider.of<EditworkoutViewModel>(context,
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
                              Provider.of<EditworkoutViewModel>(context,
                                      listen: false)
                                  .setdropDownNewValue(newValue!);
                            },
                            items: Provider.of<EditworkoutViewModel>(context)
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Select equipment: "),
                              ],
                            ),
                          ),
                          DropdownButton<String>(
                            value: Provider.of<EditworkoutViewModel>(context,
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
                              Provider.of<EditworkoutViewModel>(context,
                                      listen: false)
                                  .setequipmentDropDownNewValue(newValue!);
                            },
                            items: Provider.of<EditworkoutViewModel>(context)
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Select difficulty: "),
                              ],
                            ),
                          ),
                          DropdownButton<String>(
                            value: Provider.of<EditworkoutViewModel>(context,
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
                              Provider.of<EditworkoutViewModel>(context,
                                      listen: false)
                                  .setdifficultyDropDownNewValue(newValue!);
                            },
                            items: Provider.of<EditworkoutViewModel>(context)
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
                        height: mq.size.height * 0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.size.width * 0.1),
                        child: Consumer<EditworkoutViewModel>(
                          builder: (context, value, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              value.userImage != null &&
                                      value.userImage.path != ''
                                  ? Container(
                                      height: 150,
                                      width: 150,
                                      child: Image.file(
                                        File(
                                          Provider.of<EditworkoutViewModel>(
                                                  context)
                                              .userImage
                                              .path,
                                        ),
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(),
                              ElevatedButton(
                                  onPressed: () async {
                                    buildDialog(context);
                                    print(value.userImage == null);
                                    print(value.userImage.path == '');
                                  },
                                  child: Text(value.userImage != null &&
                                          value.userImage.path != ''
                                      ? 'Change photo'
                                      : 'Add photo'))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mq.size.height * 0.05,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              onPressed: () async {
                                final workoutsId = await Navigator.pushNamed(
                                    context, '/exercisesPicker') as List;
                                workoutsId.forEach((element) {
                                  Provider.of<EditworkoutViewModel>(context,
                                          listen: false)
                                      .addToExercises(element);
                                });
                                print(Provider.of<EditworkoutViewModel>(context,
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
                      Consumer2<EditworkoutViewModel, exercisesListViewModel>(
                        builder: (context, workout, exercises, child) => workout
                                .getPickedExercises.isEmpty
                            ? const Text('')
                            : ListBody(
                                children: exercises.getexercisesList
                                    .where((element) =>
                                        workout.containIdInExercises(
                                            element.id!.toInt()))
                                    .map(
                                      (e) => Dismissible(
                                        key: Key(e.id.toString()),
                                        onDismissed: (direction) {
                                          workout.removeFromExercises(
                                              e.id!.toInt());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: blueColor, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  e.name.toString(),
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: orangeColor,
                                                          fontSize: 17),
                                                ),
                                                subtitle: Text(
                                                  '${e.desc} ',
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: greyColor,
                                                          fontSize: 12),
                                                ),
                                                leading: CircleAvatar(
                                                  radius: 50,
                                                  // backgroundImage: NetworkImage(e
                                                  //             .exercise_img
                                                  //             .toString()
                                                  //             .substring(
                                                  //                 0, 4) !=
                                                  //         'http'
                                                  //     ? '$ip/${e.exercise_img}'
                                                  //     : e.exercise_img
                                                  //         .toString()),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Count',
                                                    style: TextStyle(
                                                        color: blueColor),
                                                  ),
                                                  Switch(
                                                    inactiveTrackColor:
                                                        orangeColor,
                                                    activeTrackColor:
                                                        orangeColor,
                                                    inactiveThumbColor:
                                                        orangeColor,
                                                    activeColor: orangeColor,
                                                    value: Provider.of<
                                                                EditworkoutViewModel>(
                                                            context,
                                                            listen: true)
                                                        .getSwitchVal(
                                                            e.id!.toInt()),
                                                    onChanged: (bool Val) {
                                                      Provider.of<EditworkoutViewModel>(
                                                              context,
                                                              listen: false)
                                                          .changeSwitchState(
                                                              Val,
                                                              e.id!.toInt());
                                                      print(Provider.of<
                                                                  EditworkoutViewModel>(
                                                              context,
                                                              listen: false)
                                                          .getSwitchVal(
                                                              e.id!.toInt()));
                                                    },
                                                  ),
                                                  Text(
                                                    'Time',
                                                    style: TextStyle(
                                                        color: blueColor),
                                                  ),
                                                ],
                                              ),
                                              Text(Provider.of<
                                                          EditworkoutViewModel>(
                                                      context)
                                                  .getCountVal(e.id!.toInt())
                                                  .toString()),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Provider.of<EditworkoutViewModel>(
                                                                context,
                                                                listen: false)
                                                            .decreaseCount(
                                                                e.id!.toInt());
                                                      },
                                                      child:
                                                          Icon(Icons.remove)),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Provider.of<EditworkoutViewModel>(
                                                                context,
                                                                listen: false)
                                                            .increaseCount(
                                                                e.id!.toInt());
                                                      },
                                                      child: Icon(Icons.add)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (Provider.of<EditworkoutViewModel>(context,
                                            listen: false)
                                        .userImage !=
                                    null &&
                                Provider.of<EditworkoutViewModel>(context,
                                            listen: false)
                                        .userImage
                                        .path !=
                                    '') {
                              if (formGlobalKey.currentState!.validate()) {
                                formGlobalKey.currentState!.save();
                                print('ddddddddddddd');
                                final CreateworkoutModel BackEndMessage =
                                    await EditworkoutViewModel().postWorkoutInfo(
                                        nameController.text,
                                        Provider.of<EditworkoutViewModel>(
                                                context,
                                                listen: false)
                                            .getIdOfDropDownValue()
                                            .toString(),
                                        Provider.of<EditworkoutViewModel>(
                                                context,
                                                listen: false)
                                            .equipmentDropDownNewValue
                                            .toString(),
                                        Provider.of<EditworkoutViewModel>(
                                                context,
                                                listen: false)
                                            .getIdOfDifficultyDropDownValue()
                                            .toString(),
                                        Provider.of<EditworkoutViewModel>(
                                                context,
                                                listen: false)
                                            .getPickedExercises,
                                        Provider.of<EditworkoutViewModel>(
                                                context,
                                                listen: false)
                                            .userImage,
                                        '/workout/update/${argu['id']}',
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
                                if (BackEndMessage.statusCode == 201 ||
                                    BackEndMessage.statusCode == 200) {
                                  nameController.clear();

                                  Navigator.of(context).pop();
                                }
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

  void buildDialog(BuildContext context) {
    final alert = AlertDialog(
      title: Text(
        'Photo type',
        style: TextStyle(color: blueColor),
      ),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Divider(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<EditworkoutViewModel>(context, listen: false)
                    .changePhoto(ImageSource.gallery);
              },
              child: Text(
                'From gallery',
                style: TextStyle(color: orangeColor),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<EditworkoutViewModel>(context, listen: false)
                    .changePhoto(ImageSource.camera);
              },
              child: Text(
                'From camera',
                style: TextStyle(color: orangeColor),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        // barrierDismissible: false,
        // barrierLabel: "ddddddddd",
        barrierColor: orangeColor.withOpacity(0.1),
        builder: (BuildContext ctx) {
          return alert;
        });
  }
}
