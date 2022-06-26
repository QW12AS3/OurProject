import 'package:flutter/material.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view_widgets.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
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
            likes: const {'Like': 50, 'DisLike': 10, 'Clap': 15, 'Strong': 5},
            comments: const ['Nice', 'Good Workout', 'Thanks'],
          ),
        )
      ]),
    );
  }
}
