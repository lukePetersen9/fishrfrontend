import 'dart:convert';
import 'package:sample/Models/post.dart';
import 'package:sample/Models/singlecard.dart';
import 'package:sample/singlepost.dart';

class CurrentUser {
  bool makeUser;
  String first, last, e, phone, username, profilePicture, id;
  int followingCount, followersCount;
  List<CurrentUser> followerList, followingList;
  List<SingleCard> privateCards,
      publicCards,
      postedCards,
      repostedCards,
      likedCards;

  CurrentUser();

  CurrentUser.init(
    this.id, {
    this.username = 'empty',
    this.first = 'John',
    this.last = 'Smith',
    this.e = 'example@email.com',
    this.phone = '1234567890',
    this.profilePicture =
        'https://www.jbrhomes.com/wp-content/uploads/blank-avatar.png',
  }) {
    followingCount = 0;
    followersCount = 0;
    followerList = new List<CurrentUser>();
    followingList = new List<CurrentUser>();
    publicCards = new List<SingleCard>();
    privateCards = new List<SingleCard>();
    postedCards = new List<SingleCard>();
    repostedCards = new List<SingleCard>();
    likedCards = new List<SingleCard>();
  }

  // CurrentUser.fromDatabaseUserInfo(Map<String, dynamic> json) {
  //   this.username = json['username'] as String;
  //   this.id = json['userkey'] as String;
  //   this.first = json['first_name'] as String;
  //   this.last = json['last_name'] as String;
  //   this.e = json['email'] as String;
  //   this.phone = json['phone'] as String;
  //   this.profilePicture = json['profile_picture'] as String;
  //   this.followingCount = json['following_count'] as int;
  //   this.followersCount = json['follower_count'] as int;
  //   followerList = new List<CurrentUser>();
  //   followingList = new List<CurrentUser>();
  //   publicCards = new List<SingleCard>();
  //   privateCards = new List<SingleCard>();
  //   postedCards = new List<SingleCard>();
  //   repostedCards = new List<SingleCard>();
  //   likedCards = new List<SingleCard>();
  // }
  factory CurrentUser.fromJsonQuick(Map<String, dynamic> json) {
    return CurrentUser.init(
      json['userkey'] as String,
      username: json['username'] as String,
      first: json['first_name'] as String,
      last: json['last_name'] as String,
      profilePicture: json['profile_picture'] as String,
    );
  }

  void _setUserDataFromJson(Map<String, dynamic> json) {
    this.username = json['username'] as String;
    this.id = json['userkey'] as String;
    this.first = json['first_name'] as String;
    this.last = json['last_name'] as String;
    this.e = json['email'] as String;
    this.phone = json['phone'] as String;
    this.profilePicture = json['profile_picture'] as String;
    this.followingCount = json['following_count'] as int;
    this.followersCount = json['follower_count'] as int;
  }

  void _setPrivatePostsFromJson(List<dynamic> json) {
    for (dynamic p in json) {
      print(jsonDecode(p.toString()));
    }
  }

  void parseUserData(String jsonUser) {
    Map<String, dynamic> userData = jsonDecode(jsonUser);
    _setUserDataFromJson(userData);
  }

  void parsePrivatePosts(String jsonPosts) {
    List<String> posts = jsonPosts
        .substring(2, jsonPosts.length - 2)
        .replaceAll("}, {", "<<<%*>>")
        .replaceAll("},{", "<<<%*>>")
        .split("<<<%*>>");
    for (String s in posts) {
      Map<String, dynamic> singlePost = jsonDecode("{" + s + "}");
      privateCards.add(SingleCard.fromJson(singlePost));
    }
  }

  List<CurrentUser> parseUsers(String jsonUsers) {
    final parsed = json.decode(jsonUsers).cast<Map<String, dynamic>>();
    return parsed
        .map<CurrentUser>((jsonData) => CurrentUser.fromJsonQuick(jsonData))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'first': first,
        'last': last,
        'email': e,
        'phone': phone,
        'username': username,
        'profilePicture': profilePicture,
        'userID': id,
      };

  int get privateCardListLength {
    return privateCards.length;
  }

  int get publicCardListLength {
    return publicCards.length;
  }

  int get postedCardsListLength {
    return postedCards.length;
  }

  int get repostedCardsListLength {
    return repostedCards.length;
  }

  int get likedCardsListLength {
    return likedCards.length;
  }
}
