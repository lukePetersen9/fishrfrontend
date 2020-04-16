import 'dart:io' as io;
import 'dart:convert';

import 'dart:io';

class Post {
  List<String> _encodedImages;
  List<String> _encodedVideos;
  String _title, _description, _userID;
  DateTime _time;

  Post(this._userID) {
    _title = '';
    _description = '';
    _time = null;
    _encodedImages = new List<String>(4);
    _encodedVideos = new List<String>(4);
  }

  void setTitle(String t) {
    _title = t;
  }

  void setDescription(String d) {
    _description = d;
  }

  void image1(File image) async {
    _encodedImages[0] = base64Encode(image.readAsBytesSync());
  }

  void image2(File image) async {
    _encodedImages[1] = base64Encode(image.readAsBytesSync());
  }

  void image3(File image) async {
    _encodedImages[2] = base64Encode(image.readAsBytesSync());
  }

  void image4(File image) async {
    _encodedImages[3] = base64Encode(image.readAsBytesSync());
  }

  void video1(String video) async {
    await io.File(video).readAsBytes().then(
      (value) {
        _encodedVideos[0] = base64Encode(value);
      },
    );
  }

  void video2(String video) async {
    await io.File(video).readAsBytes().then(
      (value) {
        _encodedVideos[1] = base64Encode(value);
      },
    );
  }

  void video3(String video) async {
    await io.File(video).readAsBytes().then(
      (value) {
        _encodedVideos[2] = base64Encode(value);
      },
    );
  }

  void video4(String video) async {
    await io.File(video).readAsBytes().then(
      (value) {
        _encodedVideos[3] = base64Encode(value);
      },
    );
  }

  Map<String, dynamic> toJson() {
    print('encoding');
    return {
      'image1': _encodedImages[0],
      'image2': _encodedImages[1],
      'image3': _encodedImages[2],
      'image4': _encodedImages[3],
      'video1': _encodedVideos[0],
      'video2': _encodedVideos[1],
      'video3': _encodedVideos[2],
      'video4': _encodedVideos[3],
      'title': _title,
      'description': _description,
      'userID': _userID
    };
  }
}
