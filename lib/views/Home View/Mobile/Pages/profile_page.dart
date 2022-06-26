// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).setUserData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ProfileViewModel>(
      builder: (context, user, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: user.getInfoWidgetVisible ? 70 : 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(15),
            child: AnimatedOpacity(
              opacity: user.getInfoWidgetVisible ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: user.getInfoWidgetVisible ? 100 : 0,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(user.getUserData.imageUrl),
                      onBackgroundImageError: (child, stacktrace) =>
                          const LoadingContainer(),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: blueColor, width: 2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(user.getUserData.name),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: VisibilityDetector(
                    key: Key(user.getUserData.id),
                    onVisibilityChanged: (VisibilityInfo info) {
                      if (info.visibleBounds.isEmpty)
                        user.setInfoWidgetVisible(true);
                      else
                        user.setInfoWidgetVisible(false);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(user.getUserData.imageUrl),
                      onBackgroundImageError: (child, stacktrace) =>
                          const LoadingContainer(),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: user.getUserData.role == 'Manager'
                                  ? Colors.red.shade900
                                  : (user.getUserData.role == 'Coach'
                                      ? blueColor
                                      : orangeColor),
                              width: 3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user.getUserData.name),
                    Text(
                      ' ( ${user.getUserData.role} )',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        color: user.getUserData.role == 'Manager'
                            ? Colors.red.shade900
                            : (user.getUserData.role == 'Coach'
                                ? blueColor
                                : orangeColor),
                      ),
                    ),
                  ],
                ),
                if (user.getUserData.role == 'Coach')
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      ' + Follow',
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: blueColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                Column(
                  children: List.generate(
                    40,
                    (index) => Text(user.getUserData.name),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
