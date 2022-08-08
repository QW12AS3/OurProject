import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_workout_app/components.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/main.dart';
import 'package:home_workout_app/models/challenge_model.dart';
import 'package:home_workout_app/view_models/general_challenges_view_model.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';

class GeneralChallengesView extends StatefulWidget {
  const GeneralChallengesView({Key? key}) : super(key: key);

  @override
  State<GeneralChallengesView> createState() => _GeneralChallengesViewState();
}

class _GeneralChallengesViewState extends State<GeneralChallengesView> {
  Future<List<ChallengeModel>>? futurechallengesList;
  // late List<ChallengeModel> challengesList;
  final ListViewController = ScrollController();
  @override
  void initState() {
    super.initState();
    // futurechallengesList = GeneralChallengesViewModel().getData('en', 1);
    // print(futurechallengesList);
    Future.delayed(Duration.zero).then((value) async {
      Provider.of<GeneralChallengesViewModel>(context, listen: false).reset();
      Provider.of<GeneralChallengesViewModel>(context, listen: false).getData(
          context.locale == Locale('en') ? 'en' : 'ar',
          Provider.of<GeneralChallengesViewModel>(context, listen: false).page,
          'out');
      // futurechallengesList = GeneralChallengesViewModel()
      //     .getData(context.locale == Locale('en') ? 'en' : 'ar', 1);
      print(Provider.of<GeneralChallengesViewModel>(context, listen: false)
          .challengesList);
      // challengesList = await GeneralChallengesViewModel().getData('en', 1);
      ListViewController.addListener(() {
        if (ListViewController.position.maxScrollExtent ==
            ListViewController.offset) {
          Provider.of<GeneralChallengesViewModel>(context, listen: false)
              .setIsLoading(true);
          Provider.of<GeneralChallengesViewModel>(context, listen: false)
              .getData(
                  context.locale == Locale('en') ? 'en' : 'ar',
                  Provider.of<GeneralChallengesViewModel>(context,
                          listen: false)
                      .page,
                  'out');
          // print(object)
        }
      });
    });
    // futurechallengesList = List<ChallengeModel>();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   futurechallengesList = GeneralChallengesViewModel()
    //       .getData(context.locale == Locale('en') ? 'en' : 'ar', 1);
    //   print(futurechallengesList);
    // });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose

  //   ListViewController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar:
        // Provider.of<GeneralChallengesViewModel>(context, listen: true)
        //             .isLoading ==
        //         true
        //     ? bigLoader(color: orangeColor)
        //     : Container(),
        appBar: AppBar(
          title: Text(
            'Challenges',
            style: theme.textTheme.bodyMedium!,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: Text('Diagram'),
            // ),
            Expanded(
              child: Consumer<GeneralChallengesViewModel>(
                builder: ((context, value, _) => (Provider.of<
                            GeneralChallengesViewModel>(context, listen: true)
                        .getchallengesList!
                        .isEmpty
                    ? bigLoader(color: orangeColor)
                    : RefreshIndicator(
                        onRefresh: () async {
                          Provider.of<GeneralChallengesViewModel>(context,
                                  listen: false)
                              .reset();
                          Provider.of<GeneralChallengesViewModel>(context,
                                  listen: false)
                              .getData(
                                  context.locale == Locale('en') ? 'en' : 'ar',
                                  Provider.of<GeneralChallengesViewModel>(
                                          context,
                                          listen: false)
                                      .page,
                                  'out');
                        },
                        child: ListView.builder(
                          controller: ListViewController,
                          physics: BouncingScrollPhysics(),
                          // scrollDirection: Axis.horizontal,
                          itemCount: value.challengesList?.length,
                          itemBuilder: ((context, index) {
                            if (index < value.challengesList!.length) {
                              final item = value.challengesList![index];
                              // return ListTile(title: Text(item));
                              return _buildList(
                                  context, index, value.challengesList![index]);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                        ),
                      ))),
              ),
            ),
            Provider.of<GeneralChallengesViewModel>(context, listen: true)
                        .isLoading ==
                    true
                ? bigLoader(color: orangeColor)
                : Container(),
          ],
        ),
      ),
    );
  }

  _buildList(BuildContext context, int index, ChallengeModel challengeValue) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mq.size.width * 0.01, vertical: mq.size.height * 0.01),
        child: InkWell(
          onTap: () {
            Provider.of<GeneralChallengesViewModel>(context, listen: false)
                .getSpecificChallengeData(
                    context.locale == Locale('en') ? 'en' : 'ar',
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
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 30,
                    offset: Offset(10, 15),
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(challengeValue
                                              .user_img
                                              .toString()
                                              .substring(0, 4) !=
                                          'http'
                                      ? '$ip/${challengeValue.user_img}'
                                      : challengeValue.user_img.toString()
                                  // 'https://media.istockphoto.com/photos/various-sport-equipments-on-grass-picture-id949190756?s=612x612'
                                  ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Coach ${challengeValue.user_name}',
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: blueColor),
                              ),
                              Text(
                                '${challengeValue.created_at}',
                                style: theme.textTheme.displaySmall!
                                    .copyWith(color: greyColor, fontSize: 10),
                              )
                            ],
                          ),
                        ],
                      ),
                      if (sharedPreferences.get("role_id") == 2) //TODO:
                        IconButton(
                            onPressed: () {
                              Provider.of<GeneralChallengesViewModel>(context,
                                      listen: false)
                                  .deleteSpecificChallengeData(
                                      context.locale == Locale('en')
                                          ? 'en'
                                          : 'ar',
                                      // 2
                                      challengeValue.id);
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: blueColor,
                            ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: mq.size.width * 0.3,
                        height: mq.size.height * 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress != null
                                    ? const LoadingContainer()
                                    : child,
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                // "$ip/${challengeValue.img.toString()}",
                                'https://media.istockphoto.com/photos/various-sport-equipments-on-grass-picture-id949190756?s=612x612'),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(challengeValue.name.toString()),
                            SizedBox(
                              height: mq.size.height * 0.01,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                child: Text(
                                  challengeValue.desc.toString(),
                                  style: TextStyle(color: blueColor),
                                  overflow: TextOverflow.fade,
                                  maxLines: 5,
                                  // softWrap: false,
                                  // textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mq.size.height * 0.01,
                            ),
                            Text(
                                '${challengeValue.total_count} / ${challengeValue.my_count}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          challengeValue.sub_count.toString() + ' participants',
                          style: TextStyle(
                              color: blueColor, fontWeight: FontWeight.w300)),
                      ElevatedButton(
                          onPressed: () {
                            print(challengeValue.id);
                            Provider.of<GeneralChallengesViewModel>(context,
                                    listen: false)
                                .sendParticipate(
                                    context.locale == Locale('en')
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
        ));
  }
}
