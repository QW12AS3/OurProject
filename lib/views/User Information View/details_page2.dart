import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/User%20Information%20View/user_information_widgets.dart';
import 'package:provider/provider.dart';

class Details2Page extends StatelessWidget {
  Details2Page({required this.saveFunction, Key? key}) : super(key: key);

  Function saveFunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 90,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Save'),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                  text: 'If you suffer any of this please check the box.',
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
                    children: consumer.diseases.entries
                        .map((e) => CheckboxListTile(
                            title: UserInfoCustomText(
                              text: e.key,
                              color: blueColor,
                              fontsize: 15,
                            ),
                            value: e.value,
                            onChanged: (value) {
                              consumer.changeDiseasesValue(e.key, value);
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
