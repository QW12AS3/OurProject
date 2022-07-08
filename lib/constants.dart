// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

Color orangeColor = const Color(0xFFFB8500);
Color blueColor = const Color(0xff126782);
Color greyColor = Colors.grey;

const String base_URL = 'http://192.168.1.107:8000/api';

final String ip = base_URL.replaceAll('/api', '');

const String apiKey =
    'THSzx8cmJny4DFmjvjX2calOKSduaJxb3YKC9sCuoCdEiF4J9w6qul5kRFwt1mUR';
// const String url = 'http://localhost:8000/api';

Map<String, dynamic> headers = {'accept': 'application/json'};

String token = 'Bearer;;; ' +
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMDFkNTFmNTNlODA3ZjQ0MzRkMzc2MGFlODkxNWM3NzVmODg5NDNkNjE1YTE4OGM4ZTQ4MmE0NmZkYzIzNGZmNTk2YzZlMGQzMDc3NzE5YmEiLCJpYXQiOjE2NTczMTUxNTcuNTEwNDc0LCJuYmYiOjE2NTczMTUxNTcuNTEwNDgzLCJleHAiOjE2NTc5MTk5NTcuMTc1ODI5LCJzdWIiOiIxIiwic2NvcGVzIjpbIioiXX0.NCl92mVb-zFRQAFMzQ0lXz3L1UGYdN2ULsoA34gPKbvStJtMTUOrBBgXD2qTEEU8r4dj9tLz3AvWMq-QkA6dZT0GaGQcozIh5eYEjtjy9g35XYBB6djed-Fuq9OJcS1Rqv6s2UGDwJY9rGID7HCkMV_gVkuA651bFjvT2eiPpzuPK9WImocbzpJM8Rsq2C6wqiXBzke4nxMn7knc65Wro36YUg3VBdM7jWBflVjnwH1wSBk6UJEaubpGEaH1SRpGD6_fvgx66CLVOtCmmWmTceN6Krd35bDHsGqXG2YYOCY75rKPk_O0LuRWhLFGd8BpT4zwE3t2eV_cO6xTxRwI7F1THT8kPeUfo8CLdb_-Td0HSKtXzfD4Xs1U3AKxNd6vBWSY3yrQWNJXGT6pHCYBF2yLiBVj3fbOlkfF6etAjAesZWc9yKxJaMN_401THypfmflWED-VY5xm5UMdU25tn2QyQ1fMhio97EZhSG9g_I1FuS0RP-NtKYoPSDYwqQzo9fSXK5CpAlGRUZlE-YkQl4Vg4I2wKombeqhlSv3BfLbSuiS99S44NQh2dWqc__uXwIQtzQ5e0qk5ijymxjraLRTWilhtNJBRjGqfxfQ2ZcVOAD0ElU_YjMw8ZFUJF61ij0ce0x02jGcMEaKhkhcM-cM5fUoawtAz-UnTnE_AEc0';

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

