import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/my_flutter_app_icons.dart';
import 'package:home_workout_app/views/Home%20View/Mobile/home_page.dart';

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({Key? key}) : super(key: key);

  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          drawer: const Drawer(),
          body: SafeArea(
            child: NestedScrollView(
              floatHeaderSlivers: true,
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
                        children: const [
                          HomePage(),
                          Text('2'),
                          Text('3'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
