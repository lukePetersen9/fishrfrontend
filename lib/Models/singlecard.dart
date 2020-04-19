class SingleCard {
  String t, pb, po, desc, uid;
  List<String> _imagesAndVideos;
  List<String> _likedBy;

  SingleCard(
    this.uid, {
    this.t,
    this.pb = 'Luke',
    this.po = 'now',
    this.desc,
  }) {
    this._likedBy = new List<String>();
    this._imagesAndVideos = new List<String>(8);
  }

  SingleCard.fromJson(Map<String, dynamic> json) {
    _imagesAndVideos = new List<String>(8);
    _likedBy = new List<String>();
    t = json['title'] as String;
    desc = json['description'] as String;

    po = DateTime.fromMillisecondsSinceEpoch(int.parse(json['time'] as String))
        .toIso8601String();
    pb = json['first_name'] as String;
    _imagesAndVideos[0] = json['image1'] as String;
    _imagesAndVideos[2] = json['image2'] as String;
    _imagesAndVideos[4] = json['image3'] as String;
    _imagesAndVideos[6] = json['image4'] as String;
    _imagesAndVideos[1] = json['video1'] as String;
    _imagesAndVideos[3] = json['video2'] as String;
    _imagesAndVideos[5] = json['video3'] as String;
    _imagesAndVideos[7] = json['video4'] as String;
  }

  String get title {
    return t;
  }

  String get postedBy {
    return pb;
  }

  String get postedOn {
    return po;
  }

  String get description {
    return desc;
  }

  int get numberOfLikes {
    return _likedBy.length;
  }

  void toggleLike() {
    _likedBy.contains(uid) ? _likedBy.remove(uid) : _likedBy.add(uid);
  }

  bool liked() {
    return _likedBy.contains(uid);
  }

  List<String> get pictures {
    return _imagesAndVideos.sublist(0, 4);
  }

  List<String> get videos {
    return _imagesAndVideos.sublist(4);
    ;
  }

  List<String> get likedBy {
    return _likedBy;
  }
}
