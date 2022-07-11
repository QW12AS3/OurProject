import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/view_models/health_record_view_model.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../User Information View/user_information_widgets.dart';

class AddHealthRecordView extends StatefulWidget {
  const AddHealthRecordView({Key? key}) : super(key: key);

  @override
  State<AddHealthRecordView> createState() => _AddHealthRecordViewState();
}

class _AddHealthRecordViewState extends State<AddHealthRecordView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      Provider.of<HealthRecordViewModel>(context, listen: false)
          .setDiseases(context.locale == const Locale('en') ? 'en' : 'ar');
    });
  }

  TextEditingController searchController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              child: TextField(
                onChanged: (value) {
                  Provider.of<HealthRecordViewModel>(context, listen: false)
                      .setSearchVal(value);
                },
                controller: searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: FittedBox(child: const Text('Search').tr()),
                  floatingLabelStyle: theme.textTheme.bodySmall,
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orangeColor, width: 1.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyColor, width: 1.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orangeColor, width: 1.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Consumer<HealthRecordViewModel>(
            builder: (context, consumer, child) => consumer.getAddDesc
                ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            Provider.of<HealthRecordViewModel>(context,
                                    listen: false)
                                .setSearchVal(value);
                          },
                          maxLength: 200,
                          maxLines: 5,
                          controller: descController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: FittedBox(
                                child: const Text('Description').tr()),
                            floatingLabelStyle: theme.textTheme.bodySmall,
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: orangeColor, width: 1.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
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
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          consumer.setAddDesc();
                        },
                        icon: Icon(Icons.close),
                        color: blueColor,
                      )
                    ],
                  )
                : TextButton(
                    onPressed: () {
                      consumer.setAddDesc();
                    },
                    child: Text(
                      'Add description',
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: blueColor, fontWeight: FontWeight.w200),
                    ),
                  ),
          ),
          Expanded(
            child: Consumer<HealthRecordViewModel>(
              builder: (context, consumer, child) => Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: consumer.getDiseases
                        .where((element) {
                          return element['name']
                              .toString()
                              .toLowerCase()
                              .contains(
                                  consumer.getSearchVal.toLowerCase().trim());
                        })
                        .map(
                          (e) => CheckboxListTile(
                            title: UserInfoCustomText(
                              text: e['name'].toString(),
                              color: blueColor,
                              fontsize: 15,
                            ),
                            value: e['selected'],
                            onChanged: (value) {
                              consumer.changeDiseasesValue(e['id'], value);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
