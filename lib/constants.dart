// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

Color orangeColor = const Color(0xFFFB8500);
Color blueColor = const Color(0xff126782);
Color greyColor = Colors.grey;

const String base_URL = 'http://192.168.1.111:8003/api';

const String apiKey =
    'THSzx8cmJny4DFmjvjX2calOKSduaJxb3YKC9sCuoCdEiF4J9w6qul5kRFwt1mUR';
// const String url = 'http://localhost:8000/api';

Map<String, dynamic> headers = {'accept': 'application/json'};

String token = 'Bearer ' +
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiY2E5NjRmMzE5YzFiMjA2YWIzM2ZjODMxNjc5ZTkxNDRmYzQ2ZWViOTBlYTJmZDc5MjZkOTlmMDVkZDI2ZjY3MzY2ZGNmYzY3ZTM3NjA1NWQiLCJpYXQiOjE2NTcxNDYxNjkuNTUxNzI2LCJuYmYiOjE2NTcxNDYxNjkuNTUxNzMsImV4cCI6MTY1Nzc1MDk2OS41MzMwMjcsInN1YiI6IjYiLCJzY29wZXMiOlsiKiJdfQ.EmeDcRSJSR61qw4_pZmDCHR5Vn4ST6yLy_6SdRK8uyG4KhWWCZdKT-UVORKRAoKdvP4IMyIrlFsUjNF2bj5AzUVkmIZ1VNSAymCV_S063f3d7gRi-sPPE7fni0lsOrDdZWm29jKZwoQQEDkDR1qSkHBaBoJxKL0irjnjn2ish5dipBqY-rjFzgQfG5W1KuhzisrVYOhriJhi9Hcv5u5JdAsmabbWZEUd3-lWd0qaYZyxQCirxXRuLZjexCqC3acWliRsW6WBsSBm9Ueb6Y1WOSs-8RkG8FofQyWuY9kADx698SA-RyEKtccaJ6TD3hD4-sZKpUOOa3PjoQbs9DcD1LNbtyaRTYJBkExYebzle2SLrFoI9OFKCWr7_cOFqFVU4k03Wcn2D-yUYb0La7B8yKQvgPeN4vzsNUfmv5YsYhvcdB4S0HxMuMVbc1fB978zmfpuxektxIzkw3aqn2Yvw-6m5nftEDnKZLKA5oMeLtPGzSebjnFg0qQ9rpfTL6hc2nRRhgWWc7Kt_CElQ9CRg-P3F0qr4lIYnnYF3Zya2r9y_XpMX9SvSxvICClARAHQoMTVp3aNzqQDYN-8JrrOeLIWIOX11UHgqpoorvl_3LAuOOLCg8ix-kaRe3Ln539H3XNLZ1Ys__6lVXBVsnDhPbR_ruvP5wQtRYbDhuq2rBE';

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

