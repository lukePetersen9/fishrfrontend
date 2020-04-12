import 'dart:math';
import 'package:sample/Models/singlecard.dart';
import 'simpleuser.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  bool makeUser;
  String first, last, e, phone, _username, profilePicture, _id;
  List<User> _followerList, _followingList;
  List<SingleCard> _privateCards, _publicCards;
  SimpleUser _simple;

  User();

  User.init(this._username,
      {this.first = 'Luke',
      this.last = 'Petersen',
      this.e = 'lukepetersen29@gmail.com',
      this.phone = '6143149784',
      this.profilePicture =
          'https://www.jbrhomes.com/wp-content/uploads/blank-avatar.png',
      this.makeUser = false}) {
    _simple = new SimpleUser(this.first, this.username, this.profilePicture);
    _followerList = new List<User>();
    _followingList = new List<User>();
    _publicCards = new List<SingleCard>();
    _privateCards = new List<SingleCard>();

    if (makeUser) {
      Random r = new Random();

      for (int i = r.nextInt(50); i >= 0; i--) {
        this._followerList.add(
              new User.init(
                r.nextInt(10000).toString(),
                first: r.nextInt(1000).toString(),
                makeUser: false,
              ),
            );
        this._privateCards.add(
              new SingleCard(
                t: r.nextInt(10000).toString(),
                desc: r.nextInt(10000).toString(),
              ),
            );
      }
      for (int i = r.nextInt(50); i >= 0; i--) {
        this._publicCards.add(
              new SingleCard(
                t: r.nextInt(10000).toString(),
                desc: r.nextInt(10000).toString(),
              ),
            );
        this._followingList.add(
              new User.init(
                r.nextInt(10000).toString(),
                first: r.nextInt(1000).toString(),
                makeUser: false,
              ),
            );
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'first': first,
        'last': last,
        'email': e,
        'phone': phone,
        'username': _username,
        'profilePicture': profilePicture,
        'userID': _id,
      };

  String get username {
    return _username;
  }

  String get userID {
    return _id;
  }

  setUserID(String id) {
    _id = id;
  }

  String get firstName {
    return first;
  }

  String get lastName {
    return last;
  }

  String get email {
    return e;
  }

  String get phoneNumber {
    return phone;
  }

  int get followerCount {
    return _followerList.length;
  }

  int get followingCount {
    return _followingList.length;
  }

  int get privateCardListLength {
    return _privateCards.length;
  }

  int get publicCardListLength {
    return _publicCards.length;
  }

  List<SingleCard> get privateCardList {
    return _privateCards;
  }

  List<SingleCard> get publicCardList {
    return _publicCards;
  }

  SimpleUser get simpleUser {
    return _simple;
  }
}
