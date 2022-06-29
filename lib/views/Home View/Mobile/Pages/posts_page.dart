import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/comments_model.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view_widgets.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NormalPostCard(
              coachImageUrl:
                  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg',
              postImages: const [
                'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg',
                'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg',
                'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
              ],
              coachName: 'Omar',
              title:
                  'This is a test This is a test This is a test This is a test This is a test This is a test',
              likes: const {'Like': 50, 'Dislike': 10, 'Clap': 15, 'Strong': 5},
              comments: {
                {
                  'owner': 'Omar',
                  'comment': 'Nice Workout!',
                  'date': '29/6/2022',
                  'ownerImageUrl':
                      'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
                },
                {
                  'owner': 'Fadi',
                  'comment': 'Good',
                  'date': '29/6/2022',
                  'ownerImageUrl':
                      'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
                },
                {
                  'owner': 'Philip',
                  'comment': 'thanks',
                  'date': '29/6/2022',
                  'ownerImageUrl':
                      'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg'
                }
              }.map((e) => CommentsModel.fromJson(e)).toList(),
              ctx: context,
              currentReact: Reacts.like,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: pollPostCard(
              coachImageUrl:
                  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/full-body-workout-1563458040.jpg',
              coachName: 'Omar',
              title:
                  'This is a test This is a test This is a test This is a test This is a test This is a test',
              ctx: context,
            ),
          )
        ],
      ),
    );
  }
}
