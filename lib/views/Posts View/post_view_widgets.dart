import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_workout_app/constants.dart';
import 'package:home_workout_app/view_models/Posts%20View%20Model/create_post_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TypeContainer extends StatelessWidget {
  TypeContainer(
      {required this.title,
      required this.backgroundColor,
      required this.textColor,
      Key? key})
      : super(key: key);
  Color backgroundColor;
  Color textColor;
  String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: blueColor, width: 1),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              title,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: textColor, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateNormalPostSpace extends StatefulWidget {
  CreateNormalPostSpace({Key? key}) : super(key: key);

  @override
  State<CreateNormalPostSpace> createState() => _CreateNormalPostSpaceState();
}

class _CreateNormalPostSpaceState extends State<CreateNormalPostSpace> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            maxLines: 15,
            controller: titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: FittedBox(child: const Text('Type here...').tr()),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              floatingLabelStyle: theme.textTheme.bodySmall,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: orangeColor, width: 1.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greyColor, width: 1.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: orangeColor, width: 1.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                await Provider.of<CreatePostViewModel>(context, listen: false)
                    .pickImages();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: blueColor,
                  ),
                  Text(
                    ' + Add photos',
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                await Provider.of<CreatePostViewModel>(context, listen: false)
                    .pickVideos();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.video_camera_back_outlined,
                    color: blueColor,
                  ),
                  Text(
                    ' + Add videos',
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
            )
          ],
        ),
        if (Provider.of<CreatePostViewModel>(context, listen: true)
            .getPickedImages!
            .isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft, child: Text('Photos:')),
                ),
                ListBody(
                  children:
                      Provider.of<CreatePostViewModel>(context, listen: true)
                          .getPickedImages!
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: FileImage(
                                  File(e.path),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                Divider(
                  thickness: 1,
                  color: blueColor,
                  endIndent: 50,
                  indent: 50,
                )
              ],
            ),
          ),
        if (Provider.of<CreatePostViewModel>(context, listen: true)
            .getPickedVideo!
            .isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft, child: Text('Videos:')),
                ),
                ListBody(
                  children:
                      Provider.of<CreatePostViewModel>(context, listen: true)
                          .getPickedVideo!
                          .map((e) {
                    return ListTile(
                      leading: const Text('-'),
                      title: Text(
                        e.path,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: blueColor,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
      ],
    );
  }
}
