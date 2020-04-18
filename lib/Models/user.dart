import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sample/Models/singlecard.dart';
import 'simpleuser.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  bool makeUser;
  String first, last, e, phone, _username, profilePicture, _id;
  int _followingCount, _followersCount;
  List<User> _followerList, _followingList;
  List<SingleCard> _privateCards,
      _publicCards,
      _postedCards,
      _repostedCards,
      _likedCards;
  SimpleUser _simple;

  User();

  User.loading(this._id) {
    first = '';
    last = '';
    e = '';
    phone = '';
    _username = '';
    profilePicture =
        'https://www.jbrhomes.com/wp-content/uploads/blank-avatar.png';
    _followingCount = 0;
    _followersCount = 0;
    _followerList = new List<User>();
    _followingList = new List<User>();
    _postedCards = new List<SingleCard>();
    _repostedCards = new List<SingleCard>();
  }

  User.init(
    this._username,
    this._id, {
    this.first = 'Luke',
    this.last = 'Petersen',
    this.e = 'lukepetersen29@gmail.com',
    this.phone = '6143149784',
    this.profilePicture =
        'https://www.jbrhomes.com/wp-content/uploads/blank-avatar.png',
  }) {
    _followingCount = 0;
    _followersCount = 0;
    _followerList = new List<User>();
    _followingList = new List<User>();
    _publicCards = new List<SingleCard>();
    _privateCards = new List<SingleCard>();
    _postedCards = new List<SingleCard>();
    _repostedCards = new List<SingleCard>();
    _likedCards = new List<SingleCard>();
  }

  User.search(
    this._username,
    this._id, {
    this.first = 'Luke',
    this.last = 'Petersen',
    this.profilePicture =
        'https://www.jbrhomes.com/wp-content/uploads/blank-avatar.png',
  });

  factory User.fromJsonQuick(Map<String, dynamic> json) {
    print('quick');
    return User.search(
      json['username'] as String,
      json['userkey'] as String,
      first: json['first_name'] as String,
      last: json['last_name'] as String,
      profilePicture: json['profile_picture'] as String,
    );
  }

  factory User.fromJsonFull(Map<String, dynamic> json) {
    print('full');
    return User.init(
      json['username'] as String,
      json['userkey'] as String,
      first: json['first_name'] as String,
      last: json['last_name'] as String,
      profilePicture: json['profile_picture'] as String,
    );
  }

  User parseUser(String jsonUser) {
    final parsed = json.decode(jsonUser);
    print(parsed);
    return parsed
        .map<User>((jsonData) => User.fromJsonFull(jsonData))
        .toList()
        .first;
  }

  List<User> parseUsers(String jsonUsers) {
    final parsed = json.decode(jsonUsers).cast<Map<String, dynamic>>();

    return parsed
        .map<User>((jsonData) => User.fromJsonQuick(jsonData))
        .toList();
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

  int get postedCardsListLength {
    return _postedCards.length;
  }

  int get repostedCardsListLength {
    return _repostedCards.length;
  }

  int get likedCardsListLength {
    return _likedCards.length;
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
