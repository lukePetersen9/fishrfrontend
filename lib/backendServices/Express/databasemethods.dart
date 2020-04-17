import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample/Models/post.dart';
import 'package:sample/Models/user.dart';

final String url = 'http://18.188.191.226:3000/';

Future<int> makeUser(User user) async {
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
