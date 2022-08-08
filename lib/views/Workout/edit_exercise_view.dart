import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/create_exercise_model.dart';
import 'package:home_workout_app/view_models/Workout_View_Model/create_exercise_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditExerciseView extends StatefulWidget {
  const EditExerciseView({Key? key}) : super(key: key);

  @override
  State<EditExerciseView> createState() => _EditExerciseViewState();
}

class _EditExerciseViewState extends State<EditExerciseView> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController BurnCaloriesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var argu;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      argu = args;
      setState(() {
        BurnCaloriesController.text = args['burn calories'] ?? '';
        nameController.text = args['name'] ?? '';
        descriptionController.text = args['description'] ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit exercise',
            style: theme.textTheme.bodyMedium!,
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              // controller: controller,
              child: Column(
                children: [
                  Center(
                    child: Form(
                      key: formGlobalKey,
                      child: Column(children: [
                        SizedBox(
                          height: mq.size.height * 0.1,
                        ),
                        Container(
                          width: mq.size.width * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              return CreateExerciseViewModel().checkName(
                                  value.toString(),
                                  context.locale == Locale('en') ? 'en' : 'ar');
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
                                borderSide:
                                    BorderSide(color: greyColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
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
                                CupertinoIcons.textformat_abc_dottedunderline,
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
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.1,
                        ),
                        Container(
                          width: mq.size.width * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: descriptionController,
                            validator: (value) {
                              return CreateExerciseViewModel().checkDescription(
                                  value.toString(),
                                  context.locale == Locale('en') ? 'en' : 'ar');
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
                                borderSide:
                                    BorderSide(color: greyColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              labelText: 'Description'.tr(),
                              labelStyle: TextStyle(
                                  color: orangeColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.description_outlined,
                                color: blueColor,
                                size: 33,
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(300),
                            ],
                            style: TextStyle(
                                color: blueColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                          ),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.1,
                        ),
                        Container(
                          width: mq.size.width * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: BurnCaloriesController,
                            validator: (value) {
                              return CreateExerciseViewModel().checkCalories(
                                  value.toString(),
                                  context.locale == Locale('en') ? 'en' : 'ar');
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              labelText: 'Burn calories'.tr(),
                              labelStyle: TextStyle(
                                  color: orangeColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.keyboard_capslock_outlined,
                                color: blueColor,
                                size: 33,
                              ),
                              suffixText: 'Kcal',
                            ),
                            style: TextStyle(
                                color: blueColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mq.size.width * 0.1),
                          child: Consumer<CreateExerciseViewModel>(
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
                                            Provider.of<CreateExerciseViewModel>(
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
                        ElevatedButton(
                            onPressed: () async {
                              // final CreateExerciseModel BackEndMessage =
                              //     await CreateExerciseViewModel().postExerciseInfo(
                              //         'nameController.text',
                              //         '10',
                              //         Provider.of<CreateExerciseViewModel>(context,
                              //                 listen: false)
                              //             .userImage,
                              //         context.locale == Locale('en') ? 'en' : 'ar');
                              if (Provider.of<CreateExerciseViewModel>(context,
                                              listen: false)
                                          .userImage !=
                                      null &&
                                  Provider.of<CreateExerciseViewModel>(context,
                                              listen: false)
                                          .userImage
                                          .path !=
                                      '') {
                                if (formGlobalKey.currentState!.validate()) {
                                  formGlobalKey.currentState!.save();
                                  final CreateExerciseModel BackEndMessage =
                                      await CreateExerciseViewModel()
                                          .postExerciseInfo(
                                              nameController.text,
                                              descriptionController.text,
                                              BurnCaloriesController.text,
                                              Provider.of<CreateExerciseViewModel>(
                                                      context,
                                                      listen: false)
                                                  .userImage,
                                              '/excersise/update/${argu['id']}',
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
                                    BurnCaloriesController.clear();
                                    Provider.of<CreateExerciseViewModel>(
                                            context,
                                            listen: false)
                                        .resetImage();

                                    Navigator.of(context).pop();
                                  }
                                }
                              } else {
                                print(argu['id']);
                                final CreateExerciseModel BackEndMessage =
                                    await CreateExerciseViewModel()
                                        .editExerciseInfo(
                                            nameController.text,
                                            descriptionController.text,
                                            BurnCaloriesController.text,
                                            argu['id'],
                                            context.locale == Locale('en')
                                                ? 'en'
                                                : 'ar');
                                print(BackEndMessage.statusCode);
                                print(BackEndMessage.message);
                                if (BackEndMessage.message != null &&
                                    BackEndMessage.message != '') {
                                  showSnackbar(
                                      Text(BackEndMessage.message.toString()),
                                      context);
                                  if (BackEndMessage.statusCode == 201 ||
                                      BackEndMessage.statusCode == 200) {
                                    nameController.clear();
                                    BurnCaloriesController.clear();
                                    Navigator.of(context).pop();
                                  }
                                }
                              }
                              // final CreateExerciseModel BackEndMessage =
                              //     await CreateExerciseViewModel().editExerciseInfo(
                              //         'nameController.text',
                              //         '10',
                              //         // Provider.of<CreateExerciseViewModel>(context,
                              //         //         listen: false)
                              //         //     .userImage,
                              //         context.locale == Locale('en') ? 'en' : 'ar');
                            },
                            child: Text('Save')),
                        SizedBox(
                          height: mq.size.height * 0.05,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
                Provider.of<CreateExerciseViewModel>(context, listen: false)
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
                Provider.of<CreateExerciseViewModel>(context, listen: false)
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

/*
ElevatedButton(
                onPressed: () {
                  Provider.of<CreateExerciseViewModel>(context, listen: false)
                      .changePhoto(ImageSource.gallery);
                },
                child: Text('Add photo')),
            ElevatedButton(
                onPressed: () async {
                  // final CreateExerciseModel BackEndMessage =
                  //     await CreateExerciseViewModel().postExerciseInfo(
                  //         'nameController.text',
                  //         '10',
                  //         Provider.of<CreateExerciseViewModel>(context,
                  //                 listen: false)
                  //             .userImage,
                  //         context.locale == Locale('en') ? 'en' : 'ar');

                  final CreateExerciseModel BackEndMessage =
                      await CreateExerciseViewModel().editExerciseInfo(
                          'nameController.text',
                          '10',
                          // Provider.of<CreateExerciseViewModel>(context,
                          //         listen: false)
                          //     .userImage,
                          context.locale == Locale('en') ? 'en' : 'ar');
                },
                child: Text('Save')),
            ElevatedButton(
                onPressed: () async {
                  // final CreateExerciseModel BackEndMessage =
                  //     await CreateExerciseViewModel().postExerciseInfo(
                  //         'nameController.text',
                  //         '10',
                  //         Provider.of<CreateExerciseViewModel>(context,
                  //                 listen: false)
                  //             .userImage,
                  //         context.locale == Locale('en') ? 'en' : 'ar');

                  await CreateExerciseViewModel().deleteSpecificChallengeData(
                      context.locale == Locale('en') ? 'en' : 'ar', 10);
                },
                child: Text('delete')),
                */