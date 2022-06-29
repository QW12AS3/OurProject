import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/views/sign%20in%20view/sigin_view.dart';
import 'package:video_player/video_player.dart';

class StartView extends StatefulWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  late VideoPlayerController videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoController = VideoPlayerController.asset("assets/videos/intro.mp4")
      ..initialize().then((value) {
        setState(() {});
      });
    videoController.setVolume(0);
    videoController.setLooping(true);
    videoController.addListener(() {
      setState(() {});
    });
    videoController.play();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
    print("ddddddddddddddddddddddddddddddddddddddddddddddddddddddispose video");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // decoration: BoxDecoration(),
            width: double.infinity,
            child: videoController.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.fill,
                    // alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: videoController.value.size.width,
                      height: videoController.value.size.height,
                      child: AspectRatio(
                        child: VideoPlayer(videoController),
                        aspectRatio: videoController.value.aspectRatio,
                      ),
                    ),
                    //            //  decoration: BoxDecoration(),
                    // // color: Colors.green,
                    // // child: FittedBox(
                    // //   fit: BoxFit.cover,
                    // //   child: SizedBox(
                    // //     width: MediaQuery.of(context).size.width,
                    // //     height: MediaQuery.of(context).size.height,
                    // //     child: VideoPlayer(videoController),
                    // //   ),
                    // // ))
                  )
                : Container(),
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: mq.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          'Vigor',
                          style: TextStyle(
                              color: orangeColor,
                              fontSize: 55,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: mq.size.width * 0.05,
                    ),
                    Container(
                      child: SvgPicture.asset(
                        'assets/images/vigorlogo.svg',
                        semanticsLabel: 'vigor Logo',
                        height: mq.size.height * 0.1,
                        width: mq.size.width * 0.15,
                        color: orangeColor,

                        // matchTextDirection: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mq.size.height * 0.07,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mq.size.width * 0.02),
                  child: Row(
                    children: [
                      const Text(
                        '"OUR',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        ' BODIES ',
                        style: TextStyle(color: orangeColor),
                      ),
                      const Text(
                        'ARE OUR GARDENS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: mq.size.width * 0.02),
                  child: Row(
                    children: const [
                      Text(
                        ' OUR WILLS ARE OUR GARDENERS"',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: mq.size.width * 0.02),
                  child: Row(
                    children: [
                      const Text(' '),
                      Text(
                        'WILLIAM SHAKESPARE',
                        style: TextStyle(
                            fontFamily: 'JosefinSans',
                            color: orangeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mq.size.height * 0.2,
                ),
                Column(
                  children: [
                    SizedBox(height: mq.size.height * 0.1),
                    Container(
                      height: 40,
                      width: 110,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          // shape: StadiumBorder(),
                          side: BorderSide(width: 1, color: orangeColor),
                          //   elevation: 55,
                          backgroundColor: Colors.white.withOpacity(0.01),
                          //orangeColor.withOpacity(0.7),
                          primary: orangeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        onPressed: () {
                          // videoController.pause();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: orangeColor,
                              //Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Sign Up here',
                              style: theme.textTheme.bodySmall,
                            )),
                      ],
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              height: 20,
                              thickness: 5,
                              // indent: 20,
                              // endIndent: 0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Or'),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              height: 20,
                              thickness: 5,
                              // indent: 20,
                              // endIndent: 0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: mq.size.height * 0.07),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: mq.size.width * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset('assets/images/google.png')),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/facebook.png',
                            ),
                            //   iconSize: mq.size.width * 0.01,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
