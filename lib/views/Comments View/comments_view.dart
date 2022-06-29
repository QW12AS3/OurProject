import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/comments_model.dart';

class CommentsView extends StatelessWidget {
  CommentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final List<CommentsModel> comments = args['comments'];
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: comments
              .map(
                (e) => Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: blueColor, width: 2),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(e.ownerImageUrl),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Coach ${e.owner}',
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(color: blueColor),
                                  ),
                                  Text(
                                    e.date,
                                    style: theme.textTheme.displaySmall!
                                        .copyWith(
                                            color: greyColor, fontSize: 10),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: Text(
                                e.comment,
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
