import 'package:flutter/material.dart';

Color orangeColor = const Color(0xFFFB8500);
Color blueColor = const Color(0xff126782);
Color greyColor = Colors.grey;

const String base_URL = 'http://192.168.43.113:8000/api';

const String apiKey =
    'THSzx8cmJny4DFmjvjX2calOKSduaJxb3YKC9sCuoCdEiF4J9w6qul5kRFwt1mUR';
const String url = 'http://192.168.43.113:8000/api';

Map<String, dynamic> headers = {'accept': 'application/json'};

String token =
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiZDZmMThkMDZkNjA0YjhiYzhhYWI0OGI0Y2JkOGYyYmU5NDBjNTZiMTRjNWUyOTZkZGNhMmVkMWY5ZWFlMDM0MmQzZDRjNDU2MTBiMTRlNzgiLCJpYXQiOjE2NTY4NDg0NzguMTI0NzU5LCJuYmYiOjE2NTY4NDg0NzguMTI0NzY1LCJleHAiOjE2NTc0NTMyNzguMTA4NDcyLCJzdWIiOiI1Iiwic2NvcGVzIjpbIioiXX0.WkFrFrWq70WNNvt-HZemnRCTy0iYOyUTiHJwDAoVwD1zsI2L35lLNxpNyIonW-Ncx8X7OZZ5RpBk9Mb4h6H05lR1ec8TA5z_aQljBVQd2JDdyGKaTuOEwsRRuD6TxtNyq78WR_0HGGs9Rz0MmkXZvUYWwciCK7dY8EMEu6a4JoFn1E2H7PRTVGL7aJ4BlTbF4Y5lPRTZcOWRIptPN1zv2vIhjAtvMet-Qkw9DiIhlqRJHQFBNwcmJWDosTsnBGpISVNUSgkpXuqnlLy0sGDXrzGjERbGyovVzhkpBRF6ew0fZDBXfauqU4rbkHCYj8Q7YujefcT7fbkXv4q4sgGfVUr-K2fQb-KqB7i22s1o6o_sYq7uWxcl91RcEVC4umQd97NetU1WvgYRggEVgaA-k15iHWJIGgwXL7RisC75rg1lZf1iM5jcpEb_rmBCp6yCFzU1GJvbGtNDGkEO_Yoa-5j8UP3Yvea8mevJCcNbYfNGqk7kQcPM7mYR6kVXtFprW1_aG-41PaPirlBzubv-d0maXt-VTFR3ozh3xEuPk3JiGGPOkMC9XU4E9iDmHzmVC-aZw8eida-MgfELJiC5h2KBrDHPZrCzXGHryrzNYNOJZyi6FXWTrrw-ZuMlkVgtkvGdi3hASyZXdGvHLyBYuYm_tMl13mVlUZgHR71r9x4';

enum Gender { male, female }

enum Units { kg, lb, cm, ft }

enum Reacts { like, dislike, clap, strong, none }

//temporary

