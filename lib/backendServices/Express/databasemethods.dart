import 'dart:convert';
import 'package:http/http.dart';
import 'package:sample/Models/post.dart';
import 'package:sample/Models/user.dart';

final String url = 'http://18.188.191.226:3000/';

Future<int> makeUser(User user) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try {
    Response response = await post(
      url + 'makeUser',
      headers: headers,
      body: json.encode(user),
    );
    return response.statusCode;
  } catch (e) {
    return 1;
  }
}

Future<int> sendPost(Post _post) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  print('heille ');
  try {
    Response response = await post(
      url + 'makepost',
      headers: headers,
      body: json.encode(_post),
    );
    return response.statusCode;
  } catch (e) {
    print(e);
    return 1;
  }
}
