import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_workout_app/view_models/Diet%20View%20Model/Diet/saved_diets_view_model.dart';
import 'package:provider/provider.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../view_models/profile_view_model.dart';

class SavedDietsView extends StatefulWidget {
  const SavedDietsView({Key? key}) : super(key: key);

  @override
  State<SavedDietsView> createState() => _SavedDietsViewState();
}

class _SavedDietsViewState extends State<SavedDietsView> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      Provider.of<SavedDietsViewModel>(context, listen: false).reset();
      Provider.of<SavedDietsViewModel>(context, listen: false).getDietsList(
        lang: context.locale == const Locale('en') ? 'en' : 'ar',
      );
      _scrollController.addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          Provider.of<SavedDietsViewModel>(context, listen: false).getDietsList(
            lang: context.locale == const Locale('en') ? 'en' : 'ar',
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Saved diets',
          style: theme.textTheme.bodyMedium!,
        ).tr(),
      ),
      body: Consumer<SavedDietsViewModel>(
        builder: (context, saveddiets, child) => (saveddiets.getIsLoading &&
                saveddiets.getSavedDiets.isEmpty)
            ? Center(child: bigLoader(color: orangeColor))
            : (saveddiets.getSavedDiets.isEmpty
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'There are no saved diets',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: greyColor),
                        ),
                        TextButton(
                          onPressed: () async {
                            Provider.of<SavedDietsViewModel>(context,
                                    listen: false)
                                .setPage(0);
                            Provider.of<SavedDietsViewModel>(context,
                                    listen: false)
                                .reset();
                            await Provider.of<SavedDietsViewModel>(context,
                                    listen: false)
                                .getDietsList(
                              lang: context.locale == const Locale('en')
                                  ? 'en'
                                  : 'ar',
                            );
                          },
                          child: Text(
                            'Refresh',
                            style: theme.textTheme.bodySmall!.copyWith(
                                color: orangeColor,
                                fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    ),
                  )
                : RefreshIndicator(
                    color: orangeColor,
                    onRefresh: () async {
                      Provider.of<SavedDietsViewModel>(context, listen: false)
                          .setPage(0);
                      Provider.of<SavedDietsViewModel>(context, listen: false)
                          .reset();
                      await Provider.of<SavedDietsViewModel>(context,
                              listen: false)
                          .getDietsList(
                        lang:
                            context.locale == const Locale('en') ? 'en' : 'ar',
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: Column(
                              children: saveddiets.getSavedDiets
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/specDiet',
                                            arguments: {'dietId': e.id});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: blueColor, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                trailing: PopupMenuButton(
                                                  onSelected: (value) async {
                                                    switch (value) {
                                                      case 'save':
                                                        break;

                                                      default:
                                                    }
                                                  },
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                        value: 'save',
                                                        child: Text(
                                                          e.saved
                                                              ? 'Saved'
                                                              : 'Save',
                                                          style: theme.textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: e.saved
                                                                      ? Colors
                                                                          .amber
                                                                      : blueColor),
                                                        ).tr()),
                                                  ],
                                                ),
                                                title: Text(
                                                  '${e.userFname} ${e.userLname}',
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: orangeColor),
                                                ),
                                                leading: CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(e.userImg),
                                                ),
                                                subtitle: Text(
                                                  e.createAt,
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: greyColor,
                                                          fontSize: 10),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 10),
                                                child: Text(
                                                  e.name,
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 10),
                                                child: Row(
                                                  children: [
                                                    Text('Meals: ',
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall)
                                                        .tr(),
                                                    Text(
                                                      e.mealsCount.toString(),
                                                      style: theme
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              color: greyColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25,
                                                        vertical: 10),
                                                    child: RatingBar.builder(
                                                      itemCount: 5,
                                                      allowHalfRating: true,
                                                      unratedColor: greyColor,
                                                      initialRating: e.rating,
                                                      maxRating: 5,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (value) {
                                                        return;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (Provider.of<ProfileViewModel>(
                                                          context,
                                                          listen: true)
                                                      .getUserData
                                                      .id !=
                                                  e.userId)
                                                Center(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  ctx) =>
                                                              AlertDialog());
                                                    },
                                                    child: Text(
                                                      'Add a review',
                                                      style: theme
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              color:
                                                                  Colors.amber),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        if (saveddiets.getIsLoading &&
                            saveddiets.getSavedDiets.isNotEmpty)
                          bigLoader(color: orangeColor)
                      ],
                    ),
                  )),
      ),
    );
  }
}
