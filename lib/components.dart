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