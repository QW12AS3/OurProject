import 'package:flutter/material.dart';
import 'package:home_workout_app/view_models/user_information_view_model.dart';
import 'package:home_workout_app/views/User%20Information%20View/details_page1.dart';
import 'package:home_workout_app/views/User%20Information%20View/details_page2.dart';
import 'package:provider/provider.dart';

class UserInformationView extends StatelessWidget {
  UserInformationView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey();

  final PageController _pageController = PageController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      bottomNavigationBar: Image(
        height: mq.size.width * 0.1,
        width: double.infinity,
        fit: BoxFit.fill,
        image: const AssetImage('assets/images/wave_background.png'),
        filterQuality: FilterQuality.high,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Details1Page(
                  heightController: heightController,
                  weightController: weightController,
                  formkey: _formkey,
                  nextFunction: () {
                    if (_formkey.currentState != null) {
                      if (_formkey.currentState!.validate()) {
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      }
                    } else if (Provider.of<UserInformationViewModel>(context,
                            listen: false)
                        .checkHWValues(heightController.text.trim(),
                            weightController.text.trim(), context)) {}
                  }),
              Details2Page(saveFunction: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
