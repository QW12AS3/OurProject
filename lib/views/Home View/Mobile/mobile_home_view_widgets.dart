import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
