// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/comments_model.dart';
import 'package:home_workout_app/my_flutter_app_icons.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';

import '../../../view_models/Home View Model/mobile_home_view_model.dart';

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
        FittedBox(child: Text(title1, style: theme.textTheme.bodySmall).tr()),
        Text(title2, style: theme.textTheme.bodySmall).tr()
      ],
    );
  }
}

class NormalPostCard extends StatefulWidget {
  NormalPostCard(
      {required this.coachName,
      required this.coachImageUrl,
      required this.title,
      required this.postImages,
      required this.comments,
      required this.likes,
      required this.currentReact,
      required this.ctx,
      Key? key})
      : super(key: key);

  String coachName;
  String currentReact;
  String coachImageUrl;
  List<String> postImages;
  String title;
  Map<String, int> likes;
  List<CommentsModel> comments;
  BuildContext ctx;

  @override
  State<NormalPostCard> createState() => _NormalPostCardState();
}

class _NormalPostCardState extends State<NormalPostCard> {
  final PageController _pageController = PageController();
  int currentPhotoIndex = 0;
  bool openContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPhotoIndex = _pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Container(
      height: 500,
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
                  backgroundImage: NetworkImage(widget.coachImageUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coach ${widget.coachName}',
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
              widget.title,
              style:
                  theme.textTheme.bodyMedium!.copyWith(color: Colors.black54),
            ),
          ),
          if (widget.postImages.length == 1)
            Image(
              image: NetworkImage(
                widget.postImages[0],
              ),
            ),
          if (widget.postImages.length > 1)
            Expanded(
              child: PageView(
                controller: _pageController,
                children: widget.postImages
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
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                widget.postImages.length > 1
                    ? '${currentPhotoIndex + 1}/${widget.postImages.length} Photos'
                    : '${currentPhotoIndex + 1}/${widget.postImages.length} Photo',
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (openContainer)
                      setState(() {
                        openContainer = false;
                      });
                  },
                  onLongPress: () {
                    setState(() {
                      openContainer = !openContainer;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: openContainer ? 200 : 75,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: greyColor, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              openContainer = false;
                            });
                          },
                          child: Icon(
                            reacts.firstWhere((element) =>
                                element['id'] ==
                                widget.currentReact)['icon'] as IconData,
                            color: orangeColor,
                          ),
                        ),
                        if (openContainer)
                          const SizedBox(
                            width: 20,
                          ),
                        if (openContainer)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: reacts
                                .where((element) =>
                                    element['id'] != widget.currentReact)
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        openContainer = !openContainer;
                                        widget.currentReact =
                                            e['id'].toString();
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        e['icon'] as IconData,
                                        color: greyColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: AnimatedOpacity(
                //     opacity: openContainer ? 1 : 0,
                //     duration: const Duration(milliseconds: 300),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.transparent,
                //         borderRadius: BorderRadius.circular(15),
                //         border: Border.all(color: greyColor, width: 1),
                //       ),
                //       child: Icon(
                //         Icons.thumb_up_alt_rounded,
                //         color: greyColor,
                //       ),
                //     ),
                //   ),
                // ),
                TextButton(
                    onPressed: () {
                      // showBottomSheet(
                      //     context: context,
                      //     builder: (ctx) => BottomSheet(
                      //           shape: const RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(15),
                      //                   topRight: Radius.circular(15))),
                      //           onClosing: () {},
                      //           builder: (BuildContext context) => SizedBox(
                      //             width: double.infinity,
                      //             height: mq.size.height * 0.75,
                      //             child: Column(
                      //               children:
                      //                   comments.map((e) => Text(e)).toList(),
                      //             ),
                      //           ),
                      //         ));
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/comments',
                            arguments: {'comments': widget.comments});
                      },
                      child: Row(
                        children: [
                          Text(
                            'Comments',
                            style: theme.textTheme.bodySmall,
                          ).tr(),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                            color: orangeColor,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class pollPostCard extends StatelessWidget {
  pollPostCard(
      {required this.coachName,
      required this.coachImageUrl,
      required this.title,
      required this.votes,
      required this.role,
      required this.ctx,
      Key? key})
      : super(key: key);

  String role;
  String coachName;
  String coachImageUrl;
  String title;
  List votes = [];
  BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    print(votes);
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                      '$role $coachName',
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
            ListBody(
              children: votes
                  .map(
                    (e) => Consumer<MobileHomeViewModel>(
                      builder: (context, value, child) => RadioListTile<int>(
                        value: e['vote_id'],
                        groupValue: value.getRadioValue,
                        onChanged: (selectedvalue) {
                          value.setRadioValue(selectedvalue ?? 0);
                        },
                        title: Text(e['vote']),
                        secondary: Text(e['rate']),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

showBottomList(BuildContext context, String title, List user) {
  print(user);

  final theme = Theme.of(context);
  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (BuildContext ctx) => Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(color: blueColor),
              ).tr(),
            ),
            Column(
              children: user.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if (Provider.of<ProfileViewModel>(context, listen: false)
                              .getUserData
                              .id
                              .toString() ==
                          e['id'].toString()) {
                        Navigator.pushNamed(context, '/home',
                            arguments: {'page': 2});
                      } else {
                        Navigator.pushNamed(context, '/anotherUserProfile',
                            arguments: {'id': e['id']});
                      }
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              e['img'].toString().substring(0, 4) != 'http'
                                  ? '$ip/${e['img']}'
                                  : e['img']),
                          onBackgroundImageError: (child, stacktrace) =>
                              const LoadingContainer(),
                          child: Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            e['name'].toString(),
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}

// InkWell(
//                       onTap: () {
//                         setState(() {
//                           if (widget.currentReact == Reacts.like)
//                             widget.currentReact = Reacts.none;
//                           else
//                             widget.currentReact = Reacts.like;
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: widget.currentReact == Reacts.like
//                               ? Border.all(color: blueColor, width: 2)
//                               : null,
//                         ),
//                         child: Icon(
//                           MyFlutterApp.thumbs_up,
//                           color: orangeColor,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       widget.likes['Like'].toString(),
//                       style: theme.textTheme.bodySmall!
//                           .copyWith(color: Colors.black, fontSize: 15),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           if (widget.currentReact == Reacts.dislike)
//                             widget.currentReact = Reacts.none;
//                           else
//                             widget.currentReact = Reacts.dislike;
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: widget.currentReact == Reacts.dislike
//                               ? Border.all(color: blueColor, width: 2)
//                               : null,
//                         ),
//                         child: Icon(
//                           MyFlutterApp.thumbs_down,
//                           color: orangeColor,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       widget.likes['Dislike'].toString(),
//                       style: theme.textTheme.bodySmall!
//                           .copyWith(color: Colors.black, fontSize: 15),
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           if (widget.currentReact == Reacts.clap)
//                             widget.currentReact = Reacts.none;
//                           else
//                             widget.currentReact = Reacts.clap;
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: widget.currentReact == Reacts.clap
//                               ? Border.all(color: blueColor, width: 2)
//                               : null,
//                         ),
//                         child: Icon(
//                           MyFlutterApp.clapping_svgrepo_com,
//                           color: orangeColor,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       widget.likes['Clap'].toString(),
//                       style: theme.textTheme.bodySmall!
//                           .copyWith(color: Colors.black, fontSize: 15),
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           if (widget.currentReact == Reacts.strong)
//                             widget.currentReact = Reacts.none;
//                           else
//                             widget.currentReact = Reacts.strong;
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: widget.currentReact == Reacts.strong
//                               ? Border.all(color: blueColor, width: 2)
//                               : null,
//                         ),
//                         child: Icon(
//                           MyFlutterApp.muscle_svgrepo_com__1_,
//                           color: orangeColor,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       widget.likes['Strong'].toString(),
//                       style: theme.textTheme.bodySmall!
//                           .copyWith(color: Colors.black, fontSize: 15),
//                     )
