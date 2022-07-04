import 'package:flutter/material.dart';
import 'package:home_workout_app/models/user_model.dart';
import 'package:home_workout_app/view_models/another_user_profile_view_model.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/Pages/profile_page.dart';
import 'package:provider/provider.dart';

class AnotherUserProfileView extends StatefulWidget {
  const AnotherUserProfileView({Key? key}) : super(key: key);

  @override
  State<AnotherUserProfileView> createState() => _AnotherUserProfileViewState();
}

class _AnotherUserProfileViewState extends State<AnotherUserProfileView> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //toolbarHeight: 45,
          ),
      body: ProfilePage(
        id: 2,
      ),
    );
  }
}
