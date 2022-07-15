// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/comments_model.dart';
import 'package:home_workout_app/view_models/Posts%20View%20Model/posts_view_model.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view_widgets.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      Provider.of<PostsViewModel>(context, listen: false)
          .setPosts(context.locale == Locale('en') ? 'en' : 'ar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<PostsViewModel>(
        builder: (context, posts, child) => Column(
          children: posts.getPosts.map((e) {
            if (e.type == 2)
              return pollPostCard(
                  role: e.pubRole,
                  coachName: e.pubName,
                  coachImageUrl: e.pubImageUrl,
                  title: e.title,
                  votes: e.choices,
                  ctx: context);
            else
              return Text('');
          }).toList(),
        ),
      ),
    );
  }
}
