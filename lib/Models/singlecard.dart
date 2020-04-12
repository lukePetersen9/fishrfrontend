import 'package:scoped_model/scoped_model.dart';
import 'simpleUser.dart';

class SingleCard extends Model {
  SimpleUser user;
  String t, pb, po, desc;
  List<String> _pics, _vids;
  List<SimpleUser> _likedBy;

  SingleCard({
    this.t,
    this.pb = 'Luke',
    this.po = 'now',
    this.desc,
    this.user,
  }) {
    this._likedBy = new List<SimpleUser>();
    this._pics = [
      'https://lukebucket1.s3.us-east-2.amazonaws.com/211CF99A-3B5D-448B-A03B-E029BAD157A5.JPG',
      'https://lukebucket1.s3.us-east-2.amazonaws.com/B6E74C53-5E04-49E5-96CA-E796CD8EC19A.JPG'
    ];
    this._vids = [
      'https://lukebucket1.s3.us-east-2.amazonaws.com/3FDC2BED-97D8-49A5-B6B2-F342A3FB22EA.medium.MP4',
      'https://lukebucket1.s3.us-east-2.amazonaws.com/3FDC2BED-97D8-49A5-B6B2-F342A3FB22EA.medium.MP4'
    ];
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
    _likedBy.contains(user) ? _likedBy.remove(user) : _likedBy.add(user);
    notifyListeners();
  }

  bool liked() {
    print(_likedBy.contains(user));
    return _likedBy.contains(user);
  }

  List<String> get pictures {
    return _pics;
  }

  List<String> get videos {
    return _vids;
  }

  List<SimpleUser> get likedBy {
    return _likedBy;
  }
}
