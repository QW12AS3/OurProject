import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:shimmer/shimmer.dart';

class buildSummaryRow extends StatelessWidget {
  buildSummaryRow({required this.title1, required this.title2, Key? key})
      : super(key: key);
  String title1;
  String title2;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FittedBox(
          child: Text(title1, style: theme.textTheme.bodySmall),
        ),
        Text(title2, style: theme.textTheme.bodySmall)
      ],
    );
  }
}

class NormalPostCard extends StatelessWidget {
  NormalPostCard(
      {required this.coachName,
      required this.coachImageUrl,
      required this.title,
      required this.postImages,
      required this.comments,
      required this.likes,
      Key? key})
      : super(key: key);

  String coachName;
  String coachImageUrl;
  List<String> postImages;
  String title;
  Map<String, int> likes;
  List<String> comments;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: blueColor, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(coachImageUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coach $coachName',
                    style:
                        theme.textTheme.bodySmall!.copyWith(color: blueColor),
                  ),
                  Text(
                    '6/3/2022 - 5:33 PM',
                    style: theme.textTheme.displaySmall!
                        .copyWith(color: greyColor, fontSize: 10),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style:
                  theme.textTheme.bodyMedium!.copyWith(color: Colors.black54),
            ),
          ),
          if (postImages.length == 1)
            Image(
              image: NetworkImage(
                postImages[0],
              ),
            ),
          if (postImages.length > 1)
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: postImages
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Image(
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress != null
                                  ? const LoadingContainer()
                                  : child,
                          width: mq.size.width * 0.95,
                          height: 250,
                          fit: BoxFit.cover,
                          image: NetworkImage(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          if (postImages.length > 1)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '${postImages.length} Photos',
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: greyColor,
                      fontWeight: FontWeight.w200,
                      fontSize: 12),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.abc),
                    Text(
                      likes['Like'].toString(),
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: blueColor, fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.ac_unit_outlined),
                    Text(
                      likes['Dislike'].toString(),
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: blueColor, fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time),
                    Text(
                      likes['Clap'].toString(),
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: blueColor, fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.account_box_sharp),
                    Text(
                      likes['Strong'].toString(),
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: blueColor, fontSize: 15),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'Comments',
                          style: theme.textTheme.bodySmall,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: orangeColor,
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
