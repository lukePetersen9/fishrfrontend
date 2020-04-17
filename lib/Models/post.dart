import 'dart:io';

class Post {
  List<String> _imagesAndVideos;
  String _title, _description, _userID;
  DateTime _time;

  Post(this._userID) {
    _title = '';
    _description = '';
    _time = null;
    _imagesAndVideos = new List<String>(8);
  }

  void setTitle(String t) {
    _title = t;
  }

  void setDescription(String d) {
    _description = d;
  }

  void image1(File image) async {
    _imagesAndVideos[0] = image.path;
  }

  void image2(File image) async {
    _imagesAndVideos[2] = image.path;
  }

  void image3(File image) async {
    _imagesAndVideos[4] = image.path;
  }

  void image4(File image) async {
    _imagesAndVideos[6] = image.path;
  }

  void video1(String video) async {
    _imagesAndVideos[1] = video;
  }

  void video2(String video) async {
    _imagesAndVideos[3] = video;
  }

  void video3(String video) async {
    _imagesAndVideos[5] = video;
  }

  void video4(String video) async {
    _imagesAndVideos[7] = video;
  }

  get imagesAndVideos {
    return _imagesAndVideos;
  }

  get userID {
    return _userID;
  }

  get title {
    return _title;
  }

  get description {
    return _description;
  }

  get timePosted {
    return _time;
  }
}
