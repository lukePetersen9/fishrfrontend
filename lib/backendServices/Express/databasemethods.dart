import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample/Models/post.dart';
import 'package:sample/Models/currentuser.dart';

final String url = 'http://ec2-13-58-244-90.us-east-2.compute.amazonaws.com:3000/';

Future<int> makeUser(CurrentUser user) async {
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

Future<int> followUnfollowUser(String follower, String followed) async {
  try {
    var response = await http.post(
      url + 'follow/' + follower + ' ' + followed,
    );
    return response.statusCode;
  } catch (e) {
    return 1;
  }
}

Future<List<CurrentUser>> searchText(String s) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try {
    var response = await http.get(
      url + 'search/' + s,
      headers: headers,
    );
    return CurrentUser().parseUsers(response.body);
  } catch (e) {
    return null;
  }
}

Future<CurrentUser> getUserData(CurrentUser user) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try {
    var response = await http.get(
      url + 'user/' + user.id,
      headers: headers,
    );
    user.parseUserData(response.body);
    return user;
  } catch (e) {
    return null;
  }
}

Future<CurrentUser> getPrivatePosts(CurrentUser user) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try {
    var response = await http.get(
      url + 'privatePosts/' + user.id,
      headers: headers,
    );
    user.parsePrivatePosts(response.body);
    return user;
  } catch (e) {
    return null;
  }
}

Future<CurrentUser> getCompleteUserData(CurrentUser user) async {
  await getUserData(user).then((value) async {
    if (value != null) {
      user = value;
      await getPrivatePosts(value).then((value) {
        if (value != null) {
          user = value;
          return user;
        } else {
          return null;
        }
      });
    }
  });
  return user;
}

Future<List<CurrentUser>> emptySearchList() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try {
    var response = await http.get(
      url + 'searchEmpty/',
      headers: headers,
    );
    return CurrentUser().parseUsers(response.body);
  } catch (e) {
    return null;
  }
}

Future<int> sendPost(Post _post) async {
  var request = http.MultipartRequest('POST', Uri.parse(url + 'makePost'));
  for (String imvid in _post.imagesAndVideos) {
    if (imvid != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'picturesAndVideos',
          imvid,
          filename: _post.userID + imvid.substring(imvid.length - 4),
        ),
      );
    }
  }
  request.fields['userID'] = _post.userID;
  request.fields['title'] = _post.title;
  request.fields['description'] = _post.description;
  try {
    var res = await request.send();
    return res.statusCode;
  } catch (e) {
    return e;
  }
}
