// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

Color orangeColor = const Color(0xFFFB8500);
Color blueColor = const Color(0xff126782);
Color greyColor = Colors.grey;


const String base_URL = 'http://192.168.60.60:8000/api';


const String apiKey =
    'THSzx8cmJny4DFmjvjX2calOKSduaJxb3YKC9sCuoCdEiF4J9w6qul5kRFwt1mUR';
// const String url = 'http://localhost:8000/api';

Map<String, dynamic> headers = {'accept': 'application/json'};

String token = 'Bearer ' +
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiM2FkNGIyODQyNDFlNDM3M2EwZTQ2YTQ5MTVlMzY1NWUwYjI2YjJiZGQ0NmNmOTU3YWVjMWU3ZThhYjYxMjhmZDY5OTNlMTEzMWExMzE0YzQiLCJpYXQiOjE2NTcwMTE0MTIuMDQ2NjM4LCJuYmYiOjE2NTcwMTE0MTIuMDQ2NjQzLCJleHAiOjE2NTc2MTYyMTIuMDM1MDIxLCJzdWIiOiI1Iiwic2NvcGVzIjpbIioiXX0.fsspthg5bsBR1L-XxJSAzqPNEZGLxUz5zUDY4dMCvO08XOEyrVVydI_m384PkPQrhDI2TPHE0Qec6nh-Cs93ruIPFD0QOqLow71i12ggM4tS2AhHeJ40mRfNyZrp-6i2zlF2bfE-FF4l2ZIPuORVnKA_6mZRD34TUHymTUDz3JouCiU7aisljFIFC-OW2_ddrCODi4iDXmtw_tjaz4IrIOvTBtRm49dbQ8C0WUEdA-vieIKNVsp1b-PK-UTAUdiaFAawmhujJ-CZA50p1es0DZ9OueFLu_EbTYzJiWKL8PKNY14CtlNssuB66CjcDAlLHU9e0cHpSvO2UIK1RwZM-MgGSKt-wlXdtA93eBLYyFaP1tdw_erib9LA9VC2dr5VX6OxOiZmDxZk4e2D9766cclIZl2CInLQcA1AIrvuP_DJuS_dhrMRJZJM5MZl6yiuFuO9dc8ZX7ROl9BgYKcUX3bVHXiYzEGvbPNUNcMgtVRVbJbVguKXg3GHImwRkJ3DqCpD5J3qE8EO_Em_cPIsL1uqmI55NA4ZmhAVL0FI1FSQhtAb5FKgcl5XVI1H-9qDu80lsV3On92HDvVXsooBW5rtUMQ4oiOCzIYJrZQHZzsFgPrOcoqmoJ6esfFvmIBmLLLtfwSc6rC-pImAFgXSyBwAmrbw76O5NxI27mCpBCg';

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
//temporary

