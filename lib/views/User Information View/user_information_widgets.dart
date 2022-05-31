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
      duration: Duration(milliseconds: 300),
      width: mq.size.width > 400 ? mq.size.width * 0.2 : 400,
      height: mq.size.height * 0.25,
      padding: EdgeInsets.only(bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Image(
        image: AssetImage(imagePath),
      ),
    );
  }
}

class UserInfoCustomText extends StatelessWidget {
  UserInfoCustomText(
      {required this.text,
      required this.color,
      this.fontsize = 20,
      this.padding = true,
      Key? key})
      : super(key: key);
  String text;
  Color color;
  double fontsize;
  bool padding;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Padding(
      padding: padding
          ? EdgeInsets.only(left: 10, bottom: 25, top: 25)
          : EdgeInsets.all(0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: theme.textTheme.bodyMedium!
              .copyWith(color: color, fontSize: fontsize),
        ),
      ),
    );
  }
}
