import 'dart:convert';
import 'package:http/http.dart';
import 'package:sample/Models/user.dart';


Future<int> makeUser(User user) async {
  // set up POST request arguments
  String url = 'http://18.188.191.226:3000/makeuser';
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try {
    Response response =
        await post(url, headers: headers, body: json.encode(user));
    return response.statusCode;
  } catch (e) {
    return 1;
  }
}
