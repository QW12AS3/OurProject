import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_workout_app/constants.dart';
import 'package:shimmer/shimmer.dart';

class buildSummaryRow extends StatelessWidget {
  buildSummaryRow({required this.title1, required this.title2, Key? key})
      : super(key: key);
  String title1;
  String title2;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FittedBox(
          child: Text(title1, style: theme.textTheme.bodySmall),
        ),
        Text(title2, style: theme.textTheme.bodySmall)
      ],
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        width: mq.width * 0.95,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
      ),
    );
  }
}
