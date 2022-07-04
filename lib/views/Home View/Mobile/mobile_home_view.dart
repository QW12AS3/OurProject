import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/my_flutter_app_icons.dart';
import 'package:home_workout_app/view_models/Home%20View%20Model/mobile_home_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/Pages/home_page.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/Pages/profile_page.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';
import 'package:provider/provider.dart';

import 'Pages/posts_page.dart';
import 'mobile_home_view_widgets.dart';

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({Key? key}) : super(key: key);

  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).setUserData();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      Provider.of<MobileHomeViewModel>(context, listen: false)
          .setCurrentTab(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () async {
          if (_scrollController.offset > 0) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          } else {
            _tabController.animateTo(
              _tabController.index >= 0 ? (_tabController.index - 1) : 0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          }

          return false;
        },
        child: Scaffold(
            drawer: SafeArea(
              child: myDrawer(
                user: Provider.of<ProfileViewModel>(context, listen: true)
                    .getUserData,
              ),
            ),
            body: SafeArea(
                child: NestedScrollView(
              controller: _scrollController,
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  elevation: 0,
                  toolbarHeight:
                      Provider.of<MobileHomeViewModel>(context, listen: true)
                                      .getCurrentTab ==
                                  2 ||
                              Provider.of<MobileHomeViewModel>(context,
                                          listen: true)
                                      .getCurrentTab ==
                                  1
                          ? 50
                          : context.locale == const Locale('en')
                              ? 50
                              : 90,
                  bottom: Provider.of<MobileHomeViewModel>(context,
                                      listen: true)
                                  .getCurrentTab ==
                              2 ||
                          Provider.of<MobileHomeViewModel>(context,
                                      listen: true)
                                  .getCurrentTab ==
                              1
                      ? null
                      : PreferredSize(
                          preferredSize: const Size(double.infinity, 80),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  color: orangeColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: blueColor, width: 1.5),
                                ),
                                margin: const EdgeInsets.only(
                                    right: 15, left: 15, top: 15, bottom: 0),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text('Your short summary: '.tr(),
                                          style: theme.textTheme.bodySmall),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            buildSummaryRow(
                                                title1: 'Calories Burned: ',
                                                title2: '2500 kcal'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            buildSummaryRow(
                                                title1: 'Workouts finished: ',
                                                title2: '5'),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            buildSummaryRow(
                                                title1: 'BMI: ',
                                                title2: 'Normal'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            buildSummaryRow(
                                                title1: 'Weight: ',
                                                title2: '75 kg'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
              ],
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: orangeColor,
                      controller: _tabController,
                      tabs: const [
                        Icon(Icons.home),
                        Icon(
                          MyFlutterApp.newspaper,
                          size: 20,
                        ),
                        Icon(Icons.person),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          HomePage(),
                          PostsPage(),
                          Consumer<ProfileViewModel>(
                            builder: (context, value, child) => ProfilePage(
                              id: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))),
      ),
    );
  }
}
