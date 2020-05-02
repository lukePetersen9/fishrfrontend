import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample/Models/ProviderModels/usermodel.dart';
import 'package:sample/Models/post.dart';
import 'package:sample/Models/currentuser.dart';

final String url =
    'http://ec2-13-58-244-90.us-east-2.compute.amazonaws.com:3000/';

Future<int> makeUser(UserModel user) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try {
    var response = await http.post(
      url + 'makeUser',
      headers: headers,
      body: json.encode(user),
    );
    return response.statusCode;
  } catch (e) {
    return 1;
  }
}

Future<Map<String, dynamic>> getUserData(String uid) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try {
    var response = await http.get(
      url + 'user/' + uid,
      headers: headers,
    );

    return json.decode(response.body);
  } catch (e) {
    return null;
  }
}

// void _setUserDataFromJson(Map<String, dynamic> json) {
//   this.username = json['username'] as String;
//   this.id = json['userkey'] as String;
//   this.first = json['first_name'] as String;
//   this.last = json['last_name'] as String;
//   this.e = json['email'] as String;
//   this.phone = json['phone'] as String;
//   this.profilePicture = json['profile_picture'] as String;
//   this.followingCount = json['following_count'] as int;
//   this.followersCount = json['follower_count'] as int;
// }

void _setPrivatePostsFromJson(List<dynamic> json) {
  for (dynamic p in json) {
    print(jsonDecode(p.toString()));
  }
}

void parseUserData(String jsonUser) {
  Map<String, dynamic> userData = jsonDecode(jsonUser);
  // _setUserDataFromJson(userData);
}
