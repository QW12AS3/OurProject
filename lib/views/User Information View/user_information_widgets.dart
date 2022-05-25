import 'package:flutter/material.dart';
import 'package:home_workout_app/constants.dart';

class GenderContainer extends StatelessWidget {
  GenderContainer({required this.color, required this.imagePath, Key? key})
      : super(key: key);

  Color color;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: mq.size.width * 0.2,
      height: mq.size.height * 0.25,
      padding: const EdgeInsets.only(bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Image(
        image: AssetImage(imagePath),
      ),
    );
  }
}

class UserInfoCustomText extends StatelessWidget {
  UserInfoCustomText({required this.text, this.color = orangeColor, Key? key})
      : super(key: key);
  String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 25, top: 25),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: theme.textTheme.bodyMedium!.copyWith(color: color),
        ),
      ),
    );
  }
}
