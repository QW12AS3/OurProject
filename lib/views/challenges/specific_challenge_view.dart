import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/views/Home%20View/home_view_widgets.dart';

class SpecificChallenge extends StatefulWidget {
  const SpecificChallenge({Key? key}) : super(key: key);

  @override
  State<SpecificChallenge> createState() => _SpecificChallengeState();
}

class _SpecificChallengeState extends State<SpecificChallenge> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return SafeArea(
        child: Container(
      child: SingleChildScrollView(
        // controller: controller,
        child: Column(
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
                      'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                      //  "$ip/${challengeValue.img.toString()}",
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
