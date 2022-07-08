// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

Color orangeColor = const Color(0xFFFB8500);
Color blueColor = const Color(0xff126782);
Color greyColor = Colors.grey;

const String base_URL = 'http://192.168.43.113:8000/api';
final String ip = base_URL.replaceAll('/api', '');

const String apiKey =
    'THSzx8cmJny4DFmjvjX2calOKSduaJxb3YKC9sCuoCdEiF4J9w6qul5kRFwt1mUR';
// const String url = 'http://localhost:8000/api';

Map<String, dynamic> headers = {'accept': 'application/json'};

String token = 'Bearer ' +
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOWRhZWRhMmRmZDA0YzVmNTEzN2I1MmZjZDkxZDg2MTVhNzE2Njk3YWY0Y2UyZTViMzExYTU5MzQ3MzhlM2U1NzU1YWU0OWI2NGEyOTUzNjUiLCJpYXQiOjE2NTcxODY4MTUuNDM1MjI3LCJuYmYiOjE2NTcxODY4MTUuNDM1MjMxLCJleHAiOjE2NTc3OTE2MTUuNDI1NzM1LCJzdWIiOiIxIiwic2NvcGVzIjpbIioiXX0.gF-j4I9Hlh94NOTv__UyUTO-XSf4uVsyu0C607diV7RdiVv4qxU_-MJEhfEOBu1zfzSLncK_ys47DPa7dOZAnZGfUSzZuoJuV5_K7UTGUHX42GI341kxsB-Tbs7IxOneRy-tB2ng63ll4lIZYZGiP9TIlsZhUHgY7WOl7xN6e8VADsTelxOKjMfyjFQScuOaOrjZJXDLD8zCzjctA2Deb7lcIegJPVSQsiVQeCR2nu8CDPK7R_7Vpg_C-lmuGuw7AQJcu06f8LWMEVrwBsgSQ3EnCqZDnXz3YUCGVVisb5C_nYmRVyyiRfewAAsmrcpXdNw24G2bwE-uy2JyMUytsga65G7NLzc5x5NQRf1Pkka6yDoIBcF_WfS3GyurAKTvQzApDdA129ZHNdjFTc9lTLDqzSWF3rcVamYsYwb-FGa86I1eJAESeyNGHbaYenhb64sShKK8HFt7YKFvPv8lNjwt6E3-RGvm8DhOSvEDrD6mUPRuzAdTqBrAs6v44WIZC2UZJ6ZhubZYcFmCGyJhWIAJwHM8sp1nBcuAjx5soWzeevlWU6flT0vinPzJGL25bUCJ29N7Yoq1V0Fzx8wBYfjri-7xulKWq70cZompEjNqKRAJm9ckOYxCuhxrEqxEKAw5yngvLnStPHHU4oPeiopfk9p7pcTJDOIwqen9lcg';

enum Gender { male, female }

enum Units { kg, lb, cm, ft }

enum Reacts { like, dislike, clap, strong, none }

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: orangeColor,
        strokeWidth: 1.5,
      ),
    );
  }
}

String getTimezone() {
  return DateTime.now().timeZoneOffset.inMinutes.toString();
}

//temporary

