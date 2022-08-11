import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/view_models/settings_view_mode.dart';
import 'package:provider/provider.dart';

import '../components.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<SettingsViewModel>(context, listen: false)
          .setLang(getLang(context) == 'en' ? true : false, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: theme.textTheme.bodyMedium!,
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Consumer<SettingsViewModel>(
          builder: (context, settings, child) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('English',
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: settings.getLang ? orangeColor : greyColor)),
                  const SizedBox(
                    width: 5,
                  ),
                  Switch(
                    value: settings.getLang ? true : false,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Arabic',
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: !settings.getLang ? orangeColor : greyColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
