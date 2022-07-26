import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

showSnackbar(Widget content, BuildContext context) {
  if (ScaffoldMessenger.maybeOf(context) != null) {
    final mq = MediaQuery.of(context).size;

    ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: content,
      margin: EdgeInsets.symmetric(horizontal: kIsWeb ? mq.width * 0.28 : 30),
    ));
  } else {
    return;
  }
}

class smallLoader extends StatelessWidget {
  smallLoader({
    required this.color,
    Key? key,
  }) : super(key: key);
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: 10,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 1,
      ),
    );
  }
}

class bigLoader extends StatelessWidget {
  bigLoader({
    required this.color,
    Key? key,
  }) : super(key: key);
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 1,
      ),
    );
  }
}

String getLang(BuildContext context) {
  return context.locale == Locale('en') ? 'en' : 'ar';
}
