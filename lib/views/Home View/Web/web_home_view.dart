import 'package:flutter/material.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/web_home_view_model.dart';
import 'package:provider/provider.dart';

class WebHomeView extends StatelessWidget {
  const WebHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
        title: Consumer<WebHomeViewModel>(
          builder: (context, value, child) => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  value.changeSelectedPage('Home');
                },
                child: Text(
                  'Home',
                  style: theme.textTheme.bodySmall!.copyWith(
                      decoration: value.selectedPage == 'Home'
                          ? TextDecoration.underline
                          : TextDecoration.none),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              TextButton(
                onPressed: () {
                  value.changeSelectedPage('Posts');
                },
                child: Text(
                  'Posts',
                  style: theme.textTheme.bodySmall!.copyWith(
                      decoration: value.selectedPage == 'Posts'
                          ? TextDecoration.underline
                          : TextDecoration.none),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              TextButton(
                onPressed: () {
                  value.changeSelectedPage('Profile');
                },
                child: Text(
                  'Profile',
                  style: theme.textTheme.bodySmall!.copyWith(
                      decoration: value.selectedPage == 'Profile'
                          ? TextDecoration.underline
                          : TextDecoration.none),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
        ),
      ),
      body: Provider.of<WebHomeViewModel>(context, listen: true).getPage(),
    );
  }
}
