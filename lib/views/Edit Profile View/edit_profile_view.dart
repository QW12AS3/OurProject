import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:home_workout_app/view_models/edit_profile_view_model.dart';
import 'package:home_workout_app/view_models/profile_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../view_models/user_information_view_model.dart';
import '../Home View/home_view_widgets.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  GlobalKey<FormState> nameKey = GlobalKey();
  GlobalKey<FormState> hwKey = GlobalKey();
  GlobalKey<FormState> emailPassKey = GlobalKey();

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EditProfileViewModel>(context, listen: false)
        .setInitialData(context);

    final user =
        Provider.of<ProfileViewModel>(context, listen: false).getUserData;
    fnameController.text = user.fname;
    lnameController.text = user.lname;
    bioController.text = user.bio;
    emailController.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final user = args['userData'];
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddressText(title: 'Personal information:'),
            Center(
              child: Consumer<EditProfileViewModel>(
                builder: (context, value, child) => CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: value.getUserImage.path != ''
                      ? FileImage(File(value.getUserImage.path))
                      : NetworkImage(user.imageUrl) as ImageProvider,
                  onBackgroundImageError: (child, stacktrace) =>
                      const LoadingContainer(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: user.role == 'Manager'
                              ? Colors.red.shade900
                              : (user.role == 'Coach'
                                  ? blueColor
                                  : orangeColor),
                          width: 3),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              child: Text(
                'Change profile photo',
                style: theme.textTheme.bodySmall!.copyWith(color: blueColor),
              ),
              onPressed: () async {
                await Provider.of<EditProfileViewModel>(context, listen: false)
                    .changePhoto(ImageSource.gallery);
              },
            ),
            Form(
              key: nameKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 15),
                    child: TextFormField(
                      maxLines: 7,
                      maxLength: 200,
                      controller: bioController,
                      validator: (value) {},
                      onSaved: (val) {},
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: const FittedBox(child: Text('Bio')),
                        floatingLabelStyle: theme.textTheme.bodySmall,
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: orangeColor, width: 1.5),
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
                          borderSide:
                              BorderSide(color: orangeColor, width: 1.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            controller: fnameController,
                            validator: (value) {},
                            onSaved: (val) {},
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: const FittedBox(child: Text('First name')),
                              floatingLabelStyle: theme.textTheme.bodySmall,
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            controller: lnameController,
                            validator: (value) {},
                            onSaved: (val) {},
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: const FittedBox(child: Text('Last name')),
                              floatingLabelStyle: theme.textTheme.bodySmall,
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: orangeColor, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Form(
              key: hwKey,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: TextFormField(
                        controller: heightController,
                        validator: (value) {
                          if (double.tryParse(value.toString()) == null) {
                            return 'Invalid height';
                          }
                        },
                        onSaved: (val) {},
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Consumer<UserInformationViewModel>(
                            builder: (context, value, child) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (value.weightUnit != Units.cm) {
                                      value.ChangeHeightUnit(Units.cm);
                                    }
                                  },
                                  child: Text(
                                    'cm',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        fontSize: value.heightUnit == Units.cm
                                            ? 17
                                            : 15,
                                        color: value.heightUnit == Units.cm
                                            ? orangeColor
                                            : greyColor),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (value.weightUnit != Units.ft) {
                                      value.ChangeHeightUnit(Units.ft);
                                    }
                                  },
                                  child: Text(
                                    'ft',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        fontSize: value.heightUnit == Units.ft
                                            ? 17
                                            : 15,
                                        color: value.heightUnit == Units.ft
                                            ? orangeColor
                                            : greyColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.height,
                            color: orangeColor,
                          ),
                          label: const FittedBox(child: Text('Height')),
                          floatingLabelStyle: theme.textTheme.bodySmall,
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: TextFormField(
                        controller: weightController,
                        validator: (value) {
                          if (double.tryParse(value.toString()) == null) {
                            return 'Invalid weight';
                          }
                        },
                        onSaved: (val) {},
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Consumer<EditProfileViewModel>(
                            builder: (context, value, child) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (value.getWeight != Units.kg) {
                                      value.ChangeWeightUnit(Units.kg);
                                    }
                                  },
                                  child: Text(
                                    'Kg',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        fontSize: value.getWeight == Units.kg
                                            ? 15
                                            : 12,
                                        color: value.getWeight == Units.kg
                                            ? orangeColor
                                            : greyColor),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (value.getWeight != Units.lb) {
                                      value.ChangeWeightUnit(Units.lb);
                                    }
                                  },
                                  child: Text(
                                    'lb',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        fontSize: value.getWeight == Units.lb
                                            ? 17
                                            : 15,
                                        color: value.getWeight == Units.lb
                                            ? orangeColor
                                            : greyColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.monitor_weight_outlined,
                            color: orangeColor,
                          ),
                          label: const FittedBox(child: Text('Weight')),
                          floatingLabelStyle: theme.textTheme.bodySmall,
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Gender: ',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Consumer<EditProfileViewModel>(
                    builder: (context, value, child) => DropdownButton<Gender>(
                      autofocus: true,
                      elevation: 0,
                      underline: const SizedBox(),
                      focusColor: Colors.transparent,
                      iconEnabledColor: blueColor,
                      iconDisabledColor: blueColor,
                      borderRadius: BorderRadius.circular(15),
                      value: value.getGender,
                      items: Gender.values
                          .map(
                            (e) => DropdownMenuItem<Gender>(
                              value: e,
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    e.name,
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: blueColor, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (Gender? newGender) {
                        value.setGender(newGender!);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Birthdate: ',
                    style: theme.textTheme.bodySmall,
                  ),
                  Consumer<EditProfileViewModel>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd').format(value.getBirthdate),
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: blueColor),
                        ),
                        IconButton(
                          onPressed: () {
                            value.changeBirthdate(context);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: orangeColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AddressText(title: 'Account information:'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Country: ',
                    style: theme.textTheme.bodySmall,
                  ),
                  Consumer<EditProfileViewModel>(
                    builder: (context, value, child) => Row(
                      children: [
                        Text(
                          value.getCountry,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: blueColor),
                        ),
                        IconButton(
                          onPressed: () {
                            showCountryPicker(
                                context: context,
                                onSelect: (country) {
                                  value.changeCountry(country.name);
                                });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: orangeColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Consumer<EditProfileViewModel>(
              builder: (context, value, child) => Form(
                key: emailPassKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          'Change email: ',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {},
                        onSaved: (val) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: const FittedBox(child: Text('Email')),
                          floatingLabelStyle: theme.textTheme.bodySmall,
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          'Change password: ',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: TextFormField(
                        obscureText: value.getPasswordObsecure1,
                        controller: newPassword,
                        validator: (value) {},
                        onSaved: (val) {},
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(value.getPasswordObsecure1
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded),
                            onPressed: () {
                              value.setPasswordObsecure1();
                            },
                          ),
                          label: const FittedBox(child: Text('New password')),
                          floatingLabelStyle: theme.textTheme.bodySmall,
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: TextFormField(
                        obscureText: value.getPasswordObsecure2,
                        controller: confirmNewPassword,
                        validator: (value) {},
                        onSaved: (val) {},
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(value.getPasswordObsecure2
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded),
                            onPressed: () {
                              value.setPasswordObsecure2();
                            },
                          ),
                          label: const FittedBox(
                              child: Text('Confirm new password')),
                          floatingLabelStyle: theme.textTheme.bodySmall,
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: orangeColor, width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Save changes',
                style: theme.textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressText extends StatelessWidget {
  AddressText({required this.title, Key? key}) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
        child: Text(
          title,
          style: theme.textTheme.bodySmall!
              .copyWith(color: greyColor, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
