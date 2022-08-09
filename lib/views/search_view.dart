// ignore_for_file: curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/search_view_model.dart';
import 'package:home_workout_app/views/Posts%20View/post_view_widgets.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../view_models/Diet View Model/Diet/diet_list_view_model.dart';
import '../view_models/general_challenges_view_model.dart';
import '../view_models/profile_view_model.dart';
import 'Home View/Mobile/mobile_home_view_widgets.dart';
import 'Home View/home_view_widgets.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<SearchViewModel>(context, listen: false).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: TextField(
                onChanged: (value) async {
                  if (value.isNotEmpty)
                    await Provider.of<SearchViewModel>(context, listen: false)
                        .getSuggestion(
                            lang: getLang(context),
                            text: value,
                            context: context);
                },
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: FittedBox(child: const Text('Search').tr()),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  floatingLabelStyle: theme.textTheme.bodySmall,
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orangeColor, width: 1.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyColor, width: 1.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orangeColor, width: 1.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              )),
              TextButton(
                  onPressed: () async {
                    if (!_scrollController.hasListeners) {
                      _scrollController.addListener(() {
                        if (_scrollController.offset ==
                            _scrollController.position.maxScrollExtent) {
                          print('ciiiiiiiiiiiiiiii');

                          Provider.of<SearchViewModel>(context, listen: false)
                              .getSearchData(
                                  lang: getLang(context),
                                  text: _controller.text.trim(),
                                  context: context);
                        }
                      });
                    }
                    Provider.of<SearchViewModel>(context, listen: false)
                        .reset();

                    await Provider.of<SearchViewModel>(context, listen: false)
                        .getSearchData(
                            lang: getLang(context),
                            text: _controller.text.trim(),
                            context: context);
                  },
                  child: Provider.of<SearchViewModel>(context, listen: true)
                          .getIsLoading
                      ? smallLoader(color: orangeColor)
                      : Text(
                          'Go',
                          style: theme.textTheme.bodySmall,
                        ))
            ],
          ),
        ),
      ),
      body: Consumer<SearchViewModel>(
        builder: (context, search, child) => Column(
          children: [
            if (search.getSugs.isNotEmpty)
              ListBody(
                children: search.getSugs
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _controller.text = e.toString();
                            },
                            child: Text(
                              e,
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: greyColor),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            if (search.getIsSugLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: bigLoader(color: orangeColor),
              ),
            Divider(
              indent: 50,
              endIndent: 50,
              color: blueColor,
            ),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<SearchViewModel>(
                  builder: (context, consumer, child) => Row(
                    children: consumer.categories.entries
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              consumer.changeSelectedCategorie(e.key, true);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: e.value ? blueColor : greyColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  e.key,
                                  style: theme.textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                      fontSize: e.value ? 15 : 10),
                                ).tr(),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _scrollController,
                child: Builder(builder: (context) {
                  print('aaaaaaaaaa' + search.getFilter());
                  switch (search.getFilter()) {
                    case 'Users':
                      if (search.getUsers.isEmpty)
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: mq.size.width * 0.5),
                            child: Text(
                              'There are no search results',
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: greyColor),
                            ),
                          ),
                        );
                      else
                        return Column(
                          children: search.getUsers
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/anotherUserProfile',
                                          arguments: {'id': e.id});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: blueColor, width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(e.imageUrl),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${e.role} ${'${e.fname} ${e.lname}'}',
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: blueColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );

                    /////////////////////

                    case 'Posts':
                      if (search.getposts.isEmpty)
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: mq.size.width * 0.5),
                            child: Text(
                              'There are no search results',
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: greyColor),
                            ),
                          ),
                        );
                      return Column(
                        children: search.getposts.map<Widget>((e) {
                          if (e.type == 2 || e.type == 3)
                            return pollPostCard(post: e, ctx: context);
                          else
                            return NormalPostCard(post: e, ctx: context);
                        }).toList(),
                      );

                    case 'Diets':
                      if (search.getDiets.isEmpty)
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: mq.size.width * 0.5),
                            child: Text(
                              'There are no search results',
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: greyColor),
                            ),
                          ),
                        );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: search.getDiets
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/specDiet',
                                      arguments: {'dietId': e.id});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: blueColor, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/anotherUserProfile',
                                                arguments: {'id': e.userId});
                                          },
                                          child: ListTile(
                                            trailing: PopupMenuButton(
                                              onSelected: (value) async {
                                                switch (value) {
                                                  case 'edit':
                                                    Navigator.pushNamed(
                                                        context, '/editDiet',
                                                        arguments: {
                                                          'dietId': e.id,
                                                          'diet': e
                                                        });
                                                    break;

                                                  case 'save':
                                                    final response = await Provider
                                                            .of<DietListViewModel>(
                                                                context,
                                                                listen: false)
                                                        .saveDiet(
                                                            lang: getLang(
                                                                context),
                                                            id: e.id,
                                                            context: context);
                                                    if (response) {
                                                      setState(() {
                                                        e.saved = !e.saved;
                                                      });
                                                    }
                                                    break;

                                                  case 'delete':
                                                    await Provider.of<
                                                                SearchViewModel>(
                                                            context,
                                                            listen: false)
                                                        .deleteDiet(
                                                            lang: getLang(
                                                                context),
                                                            id: e.id,
                                                            context: context);
                                                    break;
                                                  default:
                                                }
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    value: 'save',
                                                    child: Text(
                                                      e.saved
                                                          ? 'Saved'
                                                          : 'Save',
                                                      style: theme
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              color: e.saved
                                                                  ? Colors.amber
                                                                  : blueColor),
                                                    ).tr()),
                                                if (Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        4 ||
                                                    Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        5 ||
                                                    Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        e.userId)
                                                  PopupMenuItem(
                                                      value: 'edit',
                                                      child: Text(
                                                        'Edit',
                                                        style: theme.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color:
                                                                    blueColor),
                                                      ).tr()),
                                                if (Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        4 ||
                                                    Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        5 ||
                                                    Provider.of<ProfileViewModel>(
                                                                context,
                                                                listen: false)
                                                            .getUserData
                                                            .roleId ==
                                                        e.userId)
                                                  PopupMenuItem(
                                                      value: 'delete',
                                                      child: Text(
                                                        'Delete',
                                                        style: theme.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
                                                      ).tr())
                                              ],
                                            ),
                                            title: Text(
                                              '${e.userFname} ${e.userLname}',
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(color: orangeColor),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(e.userImg),
                                            ),
                                            subtitle: Text(
                                              e.createAt,
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                      color: greyColor,
                                                      fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 10),
                                          child: Text(
                                            e.name,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 10),
                                          child: Row(
                                            children: [
                                              Text('Meals: ',
                                                      style: theme
                                                          .textTheme.bodySmall)
                                                  .tr(),
                                              Text(
                                                e.mealsCount.toString(),
                                                style: theme
                                                    .textTheme.bodySmall!
                                                    .copyWith(color: greyColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          endIndent: 50,
                                          indent: 50,
                                          color: blueColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25,
                                                        vertical: 10),
                                                    child: RatingBarIndicator(
                                                      rating: e.rating,
                                                      itemSize: 25,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                    )),
                                                Text(
                                                  e.rating.toString(),
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: greyColor),
                                                ),
                                              ],
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/comments',
                                                    arguments: {
                                                      'review': true,
                                                      'isReviewd': e.reviewd,
                                                      'id': e.id
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Comments',
                                                    style: theme
                                                        .textTheme.bodySmall,
                                                  ).tr(),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 15,
                                                    color: orangeColor,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        if (Provider.of<ProfileViewModel>(
                                                        context,
                                                        listen: true)
                                                    .getUserData
                                                    .id !=
                                                e.userId &&
                                            e.reviewd == false)
                                          Center(
                                            child: TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) {
                                                      double stars = 0;
                                                      return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        content: Container(
                                                            height: 240,
                                                            child: Column(
                                                              children: [
                                                                RatingBar
                                                                    .builder(
                                                                  itemCount: 5,
                                                                  allowHalfRating:
                                                                      true,
                                                                  unratedColor:
                                                                      greyColor,
                                                                  //initialRating: e.rating,
                                                                  maxRating: 5,
                                                                  itemBuilder: (context,
                                                                          index) =>
                                                                      const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (value) {
                                                                    stars =
                                                                        value;
                                                                    return;
                                                                  },
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: CustomTextField(
                                                                      maxLines:
                                                                          5,
                                                                      controller:
                                                                          _reviewController,
                                                                      title:
                                                                          'Comment'),
                                                                ),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      final response = await Provider.of<DietListViewModel>(context, listen: false).sendReview(
                                                                          lang: getLang(
                                                                              context),
                                                                          id: e
                                                                              .id,
                                                                          review: _reviewController
                                                                              .text
                                                                              .trim(),
                                                                          stars:
                                                                              stars,
                                                                          context:
                                                                              context);
                                                                      if (response) {
                                                                        setState(
                                                                            () {
                                                                          e.reviewd =
                                                                              true;
                                                                        });
                                                                        _reviewController
                                                                            .clear();
                                                                        Navigator.pop(
                                                                            ctx);
                                                                      }
                                                                    },
                                                                    child: const Text(
                                                                        'Submit'))
                                                              ],
                                                            )),
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                'Add a review',
                                                style: theme
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                        color: Colors.amber),
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
                      );

                    case 'Challenges':
                      if (search.getChallenges.isEmpty)
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: mq.size.width * 0.5),
                            child: Text(
                              'There are no search results',
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: greyColor),
                            ),
                          ),
                        );
                      return Column(
                        children: search.getChallenges
                            .map((challengeValue) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mq.size.width * 0.01,
                                    vertical: mq.size.height * 0.01),
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<GeneralChallengesViewModel>(
                                            context,
                                            listen: false)
                                        .getSpecificChallengeData(
                                            context.locale == Locale('en')
                                                ? 'en'
                                                : 'ar',
                                            challengeValue.id,
                                            'in');
                                    print('tapped');
                                    print(challengeValue.id.toString());
                                  },
                                  child: Container(
                                    // height: mq.size.height * 0.3,
                                    // width: mq.size.width * 0.95,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 30,
                                            offset: Offset(10, 15),
                                          )
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          challengeValue
                                                                      .user_img
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          4) !=
                                                                  'http'
                                                              ? '$ip/${challengeValue.user_img}'
                                                              : challengeValue
                                                                  .user_img
                                                                  .toString()),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Coach ${challengeValue.user_name}',
                                                        style: theme.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color:
                                                                    blueColor),
                                                      ),
                                                      Text(
                                                        '${challengeValue.created_at}',
                                                        style: theme.textTheme
                                                            .displaySmall!
                                                            .copyWith(
                                                                color:
                                                                    greyColor,
                                                                fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              if (sharedPreferences
                                                      .get("role_id") ==
                                                  2) //TODO:
                                                IconButton(
                                                    onPressed: () {
                                                      Provider.of<GeneralChallengesViewModel>(
                                                              context,
                                                              listen: false)
                                                          .deleteSpecificChallengeData(
                                                              context.locale ==
                                                                      Locale(
                                                                          'en')
                                                                  ? 'en'
                                                                  : 'ar',
                                                              // 2
                                                              challengeValue
                                                                  .id);
                                                    },
                                                    icon: Icon(
                                                      Icons.more_vert,
                                                      color: blueColor,
                                                    ))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: mq.size.width * 0.3,
                                                height: mq.size.height * 0.2,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image(
                                                    loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) =>
                                                        loadingProgress != null
                                                            ? const LoadingContainer()
                                                            : child,
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                      "$ip/${challengeValue.img.toString()}",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(challengeValue.name
                                                        .toString()),
                                                    SizedBox(
                                                      height:
                                                          mq.size.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 6),
                                                      child: Container(
                                                        child: Text(
                                                          challengeValue.desc
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: blueColor),
                                                          overflow:
                                                              TextOverflow.fade,
                                                          maxLines: 5,
                                                          // softWrap: false,
                                                          // textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          mq.size.height * 0.01,
                                                    ),
                                                    Text(
                                                        '${challengeValue.total_count} / ${challengeValue.my_count}'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  challengeValue.sub_count
                                                          .toString() +
                                                      ' participants',
                                                  style: TextStyle(
                                                      color: blueColor,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    print(challengeValue.id);
                                                    Provider.of<GeneralChallengesViewModel>(
                                                            context,
                                                            listen: false)
                                                        .sendParticipate(
                                                            context.locale ==
                                                                    Locale('en')
                                                                ? 'en'
                                                                : 'ar',
                                                            // 2
                                                            challengeValue.id);
                                                  },
                                                  child: Text(
                                                    'Participate', //TODO:
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )))
                            .toList(),
                      );

                    default:
                      return const Text('');
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
