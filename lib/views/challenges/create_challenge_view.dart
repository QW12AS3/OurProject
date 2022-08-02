import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/create_challenge_model.dart';
import 'package:home_workout_app/view_models/create_challenge_view_model.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

class CreateChallengeView extends StatefulWidget {
  CreateChallengeView({Key? key}) : super(key: key);

  @override
  State<CreateChallengeView> createState() => _CreateChallengeViewState();
}

class _CreateChallengeViewState extends State<CreateChallengeView> {
  final formGlobalKey = GlobalKey<FormState>();
  TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);
  TextEditingController nameController = TextEditingController();
  Future<List<CreateChallengeModel>>? futurechallengesList;
  // List<String> dropDownList = [];

  // String selectedDropDownValue = ''; //dropDownList[0];

  // List<CreateChallengeModel> posts = [];
  @override
  void initState() {
    super.initState();
    // futurechallengesList = GeneralChallengesViewModel().getData('en', 1);
    // print(futurechallengesList);
    Future.delayed(Duration.zero).then((value) async {
      futurechallengesList =
          Provider.of<CreateChallengesViewModel>(context, listen: false)
              .getData(context.locale == Locale('en') ? 'en' : 'ar', 0);

      // List data = jsonDecode(response.body)['data'] ?? [];

      // print(Provider.of<CreateChallengesViewModel>(context, listen: false).getChallengesList(lang));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final hours = initialTime.hour.toString().padLeft(2, '0');
    final minuites = initialTime.minute.toString().padLeft(2, '0');
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Create challenges',
              style: theme.textTheme.bodyMedium!,
            ),
          ),
          body: Provider.of<CreateChallengesViewModel>(context).fetchedList ==
                  true
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: mq.size.height * 0.2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: mq.size.height * 0.02,
                              ),
                              Form(
                                key: formGlobalKey,
                                child: Column(
                                  children: [
                                    /*    Container(
                            width: 380,
                            decoration: BoxDecoration(
                                color: Colors.white70.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              controller: nameController,
                              validator: (value) {
                                return ''; //TODO:
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
                                  borderSide: BorderSide(
                                      color: orangeColor, width: 1.5),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                labelText: 'Name of challenge'.tr(),
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
                                LengthLimitingTextInputFormatter(50),
                              ],
                              style: TextStyle(
                                  color: blueColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        */

                                    Row(
                                      children: [
                                        const Text("Select exercise's name: "),
                                        DropdownButton<String>(
                                          value: Provider.of<
                                                      CreateChallengesViewModel>(
                                                  context,
                                                  listen: false)
                                              .dropDownNewValue,
                                          icon: Icon(Icons.arrow_downward,
                                              color: blueColor),
                                          elevation: 16,
                                          style: TextStyle(color: blueColor),
                                          underline: Container(
                                            height: 2,
                                            color: blueColor,
                                          ),
                                          onChanged: (String? newValue) {
                                            Provider.of<CreateChallengesViewModel>(
                                                    context,
                                                    listen: false)
                                                .setdropDownNewValue(newValue!);
                                          },
                                          items: Provider.of<
                                                      CreateChallengesViewModel>(
                                                  context)
                                              .dropDownList
                                              ?.map<DropdownMenuItem<String>>(
                                                  (String value) {
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
                                      height: mq.size.height * 0.03,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: mq.size.height * 0.01,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.size.width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  Provider.of<CreateChallengesViewModel>(
                                          context,
                                          listen: false)
                                      .changePhoto(ImageSource.gallery);
                                },
                                child: Text('Add photo')),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final CreateChallengeModel BackEndMessage =
                                await CreateChallengesViewModel()
                                    .postChallengeInfo(
                                        'nameVal',
                                        '2022-8-8',
                                        'countVal',
                                        'ex_idVal',
                                        'false',
                                        Provider.of<CreateChallengesViewModel>(
                                                context,
                                                listen: false)
                                            .userImage,
                                        'descVal',
                                        context.locale == Locale('en')
                                            ? 'en'
                                            : 'ar');
                            print(Provider.of<CreateChallengesViewModel>(
                                    context,
                                    listen: false)
                                .dropDownList);
                            print(Provider.of<CreateChallengesViewModel>(
                                    context,
                                    listen: false)
                                .getIdOfDropDownValue());
                          },
                          child: Text('Save')),
                    ],
                  ),
                )
              : CustomLoading()),
    );
  }
}
/*

   // showDateRangePicker(context: context, firstDate: firstDate, lastDate: lastDate)
                        TimeOfDay? timepicked = await showTimePicker(
                            context: context,
                            initialTime: initialTime,
                            builder: (context, childWidget) {
                              return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      // Using 24-Hour format
                                      alwaysUse24HourFormat: true),
                                  // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                  child: childWidget!);
                            });
                        if (timepicked != null) {
                          setState(() {
                            initialTime = timepicked;
                            print(timepicked.hour * 60 + timepicked.minute);
                          });
                        }
                        // showTimePicker(
                        //     context: context, initialTime: initialTime);

                        */