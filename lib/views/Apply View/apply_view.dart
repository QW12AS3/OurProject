import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ApplyView extends StatefulWidget {
  ApplyView({Key? key}) : super(key: key);

  @override
  State<ApplyView> createState() => _ApplyViewState();
}

class _ApplyViewState extends State<ApplyView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apply',
          style: theme.textTheme.bodyMedium!,
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
