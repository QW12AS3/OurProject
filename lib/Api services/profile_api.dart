import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class ProfileApi {
  editProfile(
    String fname,
    String lname,
    XFile image,
    String bio,
    double height,
    double weight,
    Gender gender,
    DateTime birthdate,
    String country,
    String email,
    String password,
    String confirmPassword,
  ) async {
    const String url = '';
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['fname'] = fname;
      request.fields['lname'] = lname;
      request.fields['bio'] = bio;
      request.fields['height'] = height.toString();
      request.fields['weight'] = weight.toString();
      request.fields['gender'] = gender == Gender.male ? 'male' : 'female';
      request.fields['birthdate'] = birthdate.toString();
      request.fields['country'] = country;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['confirmPassword'] = confirmPassword;

      if (image.path != '') {
        var pic = await http.MultipartFile.fromPath("image", image.path);
        request.files.add(pic);
      }
      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
    } catch (e) {}
  }
}
