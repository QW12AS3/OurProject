import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/mobile_home_view_widgets.dart';

import '../../models/post_models.dart';
import '../Home View/home_view_widgets.dart';

class PostView extends StatefulWidget {
  PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  PageController page1Controller = PageController();

  PageController page2Controller = PageController();

  int page1index = 0;
  int page2Index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page1Controller.addListener(() {
      setState(() {
        page1index = page1Controller.page!.toInt();
      });
    });
    page2Controller.addListener(() {
      setState(() {
        page2Index = page2Controller.page!.toInt();
      });
    });
  }

  bool openContainer = false;

  String commentText = 'Comments'.tr();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    PostModel post = args['post'];

    return Scaffold(
      bottomNavigationBar: Padding(
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
                          post.myLike = post.myLike == -1 ? 1 : -1;
                        });
                      },
                      child: Icon(
                        post.myLike == -1
                            ? reacts[0]['icon'] as IconData
                            : reacts.firstWhere((element) =>
                                element['id'] ==
                                'type${post.myLike}')['icon'] as IconData,
                        color: post.myLike == -1 ? greyColor : orangeColor,
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
                            .where((element) => post.myLike != -1
                                ? element['id'] != 'type${post.myLike}'
                                : element['id'] != 'type1')
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  setState(() {
                                    openContainer = !openContainer;
                                    if (post.myLike ==
                                        int.parse(e['id']
                                            .toString()
                                            .replaceAll('type', ''))) {
                                      post.myLike = -1;
                                    } else {
                                      post.myLike = int.parse(e['id']
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
                      arguments: {'id': post.postId});
                },
                child: Row(
                  children: [
                    Text(
                      '${post.commentsCount} $commentText',
                      style: theme.textTheme.bodySmall,
                    ).tr(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: orangeColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(post.pubImageUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              post.pubName,
              style: theme.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.title,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
            if (post.imagesUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: context.locale == const Locale('en')
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    'Photos:',
                    style: theme.textTheme.bodySmall,
                  ).tr(),
                ),
              ),
            if (post.imagesUrl.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: blueColor, width: 2),
                    ),
                    child: Stack(
                      alignment: context.locale == const Locale('en')
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      children: [
                        PageView(
                            controller: page1Controller,
                            children: post.imagesUrl
                                .map(
                                  (e) => Builder(
                                    builder: (BuildContext context) {
                                      try {
                                        return Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image(
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const LoadingContainer(),
                                              loadingBuilder: (context, child,
                                                      loadingProgress) =>
                                                  loadingProgress != null
                                                      ? const LoadingContainer()
                                                      : child,
                                              width: mq.size.width * 0.95,
                                              //height: 250,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(e['url']),
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        return LoadingContainer();
                                      }
                                    },
                                  ),
                                )
                                .toList()),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: greyColor.withOpacity(0.5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${page1index + 1}/${post.imagesUrl.length}',
                                style: theme.textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            if (post.videosUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: context.locale == const Locale('en')
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    'Videos:',
                    style: theme.textTheme.bodySmall,
                  ).tr(),
                ),
              ),
            if (post.videosUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: blueColor, width: 2),
                  ),
                  child: Stack(
                    alignment: context.locale == Locale('en')
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    children: [
                      PageView(
                          controller: page2Controller,
                          children: post.videosUrl
                              .map(
                                (e) => Builder(
                                  builder: (BuildContext context) {
                                    try {
                                      return Center(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: VideoCard(
                                          videoUrl: e['url'],
                                        ),
                                      ));
                                    } catch (e) {
                                      return const LoadingContainer();
                                    }
                                  },
                                ),
                              )
                              .toList()),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: greyColor.withOpacity(0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${page2Index + 1}/${post.videosUrl.length}',
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
