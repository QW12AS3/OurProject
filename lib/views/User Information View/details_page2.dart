import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/User%20Information%20View/user_information_widgets.dart';
import 'package:provider/provider.dart';

class Details2Page extends StatefulWidget {
  Details2Page({required this.saveFunction, Key? key}) : super(key: key);

  Function saveFunction;

  @override
  State<Details2Page> createState() => _Details2PageState();
}

class _Details2PageState extends State<Details2Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      Provider.of<UserInformationViewModel>(context, listen: false)
          .setDiseases(context.locale == const Locale('en') ? 'en' : 'ar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 90,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Save').tr(),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserInfoCustomText(
                  text: 'Do you suffer any of this diseases ?',
                  padding: false,
                  color: orangeColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserInfoCustomText(
                  text: 'If you suffer any of this check the box.',
                  fontsize: 12,
                  color: greyColor,
                  padding: false,
                ),
              ),
            ],
          )),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<UserInformationViewModel>(
                builder: (context, consumer, child) => Scrollbar(
                  child: Column(
                    children: consumer.getDiseases
                        .map((e) => CheckboxListTile(
                            title: UserInfoCustomText(
                              text: e['name'].toString(),
                              color: blueColor,
                              fontsize: 15,
                            ),
                            value: e['selected'],
                            onChanged: (value) {
                              consumer.changeDiseasesValue(e['id'], value);
                            }))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  // padding: EdgeInsets.only(
  //                                 bottom: e['id'] ==
  //                                         consumer.diseases.entries.last.key
  //                                     ? 40
  //                                     : 0),