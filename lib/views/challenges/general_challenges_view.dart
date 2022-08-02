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
  @override
  void initState() {
    super.initState();
    // futurechallengesList = GeneralChallengesViewModel().getData('en', 1);
    // print(futurechallengesList);
    Future.delayed(Duration.zero).then((value) async {
      Provider.of<GeneralChallengesViewModel>(context, listen: false)
          .getData(context.locale == Locale('en') ? 'en' : 'ar', 1);
      // futurechallengesList = GeneralChallengesViewModel()
      //     .getData(context.locale == Locale('en') ? 'en' : 'ar', 1);
      print(Provider.of<GeneralChallengesViewModel>(context, listen: false)
          .futurechallengesList);
      // challengesList = await GeneralChallengesViewModel().getData('en', 1);
    });
    // futurechallengesList = List<ChallengeModel>();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   futurechallengesList = GeneralChallengesViewModel()
    //       .getData(context.locale == Locale('en') ? 'en' : 'ar', 1);
    //   print(futurechallengesList);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Challenges',
            style: theme.textTheme.bodyMedium!,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Diagram'),
            ),
            Expanded(
              child: Consumer<GeneralChallengesViewModel>(
                builder: ((context, value, _) =>
                    (FutureBuilder<List<ChallengeModel>>(
                        future: value.futurechallengesList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                // scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.length,
                                itemBuilder: ((context, index) => _buildList(
                                    context, index, snapshot.data![index])));
                          } else if (snapshot.hasError) {
                            return Text(
                                'There is a problem connecting to the internet');
                          }
                          return bigLoader(
                            color: orangeColor,
                          );
                        }))),
              ),
            )
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
                                : challengeValue.user_img.toString()),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Coach ${challengeValue.name}',
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
                          onPressed: () {},
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
                            "$ip/${challengeValue.user_img.toString()}",
                          ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 6),
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
                              '${challengeValue.my_count} / ${challengeValue.total_count}'),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(challengeValue.sub_count.toString() + ' participants',
                        style: TextStyle(
                            color: blueColor, fontWeight: FontWeight.w300)),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Participate', //TODO:
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
