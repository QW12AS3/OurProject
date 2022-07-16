// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/components.dart';
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
          .setPosts(context.locale == const Locale('en') ? 'en' : 'ar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<PostsViewModel>(context, listen: false)
            .setPosts(context.locale == const Locale('en') ? 'en' : 'ar');
      },
      color: orangeColor,
      child: Consumer<PostsViewModel>(
        builder: (context, posts, child) => posts.getIsLoading
            ? Center(child: bigLoader(color: orangeColor))
            : SingleChildScrollView(
                child: Column(
                  children: posts.getPosts.map((e) {
                    if (e.type == 2 || e.type == 3)
                      return pollPostCard(post: e, ctx: context);
                    else
                      return NormalPostCard(post: e, ctx: context);
                  }).toList(),
                ),
              ),
      ),
    );
  }
}
