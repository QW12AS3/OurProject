// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable, avoid_single_cascade_in_expression_statements

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/models/comments_model.dart';
import 'package:home_workout_app/models/post_models.dart';
import 'package:home_workout_app/my_flutter_app_icons.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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

class VideoCard extends StatefulWidget {
  VideoCard({required this.videoUrl, Key? key}) : super(key: key);
  String videoUrl;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController _video = VideoPlayerController.network('');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _video = VideoPlayerController.network(widget.videoUrl);
  }

  bool playButtonisShown = true;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return InkWell(
      onTap: () {
        setState(() {
          playButtonisShown = !playButtonisShown;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.maxFinite,
          //decoration: BoxDecoration(border: Border.all(color: blueColor)),
          child: AspectRatio(
            aspectRatio: _video.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_video),
                AnimatedOpacity(
                  opacity: playButtonisShown ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed: () {
                      print(widget.videoUrl);

                      if (_video.value.isInitialized) {
                        setState(() {
                          if (_video.value.isPlaying)
                            _video.pause();
                          else {
                            _video.play();
                            playButtonisShown = !playButtonisShown;
                          }
                        });
                      } else {
                        _video
                          ..initialize().then((value) {
                            setState(() {});
                          });
                      }
                    },
                    child: _video.value.isPlaying
                        ? const Icon(
                            Icons.pause,
                          )
                        : const Icon(
                            Icons.play_arrow_rounded,
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NormalPostCard extends StatefulWidget {
  NormalPostCard({required this.post, required this.ctx, Key? key})
      : super(key: key);

  PostModel post;
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
    print(widget.post.title + widget.post.videosUrl.toString());
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: widget.post.imagesUrl.isEmpty ? 200 : 650,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: blueColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.post.pubImageUrl),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.post.pubRole} ${widget.post.pubName}',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: blueColor),
                        ),
                        Text(
                          widget.post.createdAt,
                          style: theme.textTheme.displaySmall!
                              .copyWith(color: greyColor, fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/postView',
                        arguments: {'post': widget.post});
                  },
                  child: Text(
                    'See more >',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.w200),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.post.title,
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.black54),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  if (widget.post.imagesUrl.isNotEmpty)
                    Builder(
                      builder: (BuildContext context) {
                        try {
                          return Image(
                            errorBuilder: (context, error, stackTrace) =>
                                const LoadingContainer(),
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress != null
                                    ? const LoadingContainer()
                                    : child,
                            width: mq.size.width * 0.95,
                            height: 250,
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(widget.post.imagesUrl[0]['url']),
                          );
                        } catch (e) {
                          return const LoadingContainer();
                        }
                      },
                    ),
                  if (widget.post.videosUrl.isNotEmpty)
                    Builder(
                      builder: (BuildContext context) {
                        try {
                          return VideoCard(
                              videoUrl: widget.post.videosUrl[0]['url']);
                        } catch (e) {
                          return const LoadingContainer();
                        }
                      },
                    ),
                ],
              ),
            ),
            if (widget.post.imagesUrl.length + widget.post.videosUrl.length !=
                0)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    '${currentPhotoIndex + 1}/${widget.post.imagesUrl.length + widget.post.videosUrl.length} Media',
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
                                widget.post.myLike =
                                    widget.post.myLike == -1 ? 1 : -1;
                              });
                            },
                            child: Icon(
                              widget.post.myLike == -1
                                  ? reacts[0]['icon'] as IconData
                                  : reacts.firstWhere((element) =>
                                          element['id'] ==
                                          'type${widget.post.myLike}')['icon']
                                      as IconData,
                              color: widget.post.myLike == -1
                                  ? greyColor
                                  : orangeColor,
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
                                  .where((element) => widget.post.myLike != -1
                                      ? element['id'] !=
                                          'type${widget.post.myLike}'
                                      : element['id'] != 'type1')
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          openContainer = !openContainer;
                                          if (widget.post.myLike ==
                                              int.parse(e['id']
                                                  .toString()
                                                  .replaceAll('type', ''))) {
                                            widget.post.myLike = -1;
                                          } else {
                                            widget.post.myLike = int.parse(
                                                e['id']
                                                    .toString()
                                                    .replaceAll('type', ''));
                                          }
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
                  TextButton(
                      onPressed: () {},
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/comments',
                              arguments: {'id': widget.post.postId});
                        },
                        child: Row(
                          children: [
                            Text(
                              '${widget.post.commentsCount} Comments',
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
      ),
    );
  }
}

class pollPostCard extends StatefulWidget {
  pollPostCard({required this.post, required this.ctx, Key? key})
      : super(key: key);

  PostModel post;
  BuildContext ctx;

  @override
  State<pollPostCard> createState() => _pollPostCardState();
}

class _pollPostCardState extends State<pollPostCard> {
  int groupValue = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupValue = widget.post.myVote;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.post.choices);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.post.pubImageUrl),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.post.pubRole} ${widget.post.pubName}',
                      style:
                          theme.textTheme.bodySmall!.copyWith(color: blueColor),
                    ),
                    Text(
                      widget.post.createdAt,
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
                widget.post.title,
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.black54),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            ListBody(
              children: widget.post.choices
                  .map(
                    (e) => Consumer<MobileHomeViewModel>(
                      builder: (context, value, child) => RadioListTile<int>(
                        value: e['vote_id'],
                        groupValue: groupValue,
                        onChanged: (selectedvalue) {
                          setState(() {
                            groupValue = selectedvalue ?? 0;
                          });
                        },
                        title: Text(e['vote']),
                        secondary: groupValue == -1
                            ? null
                            : Text(
                                e['rate'] + '%',
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: blueColor),
                              ),
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
