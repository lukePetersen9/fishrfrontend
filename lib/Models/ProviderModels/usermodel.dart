import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/backendServices/databaseuser.dart';

class UserModel extends ChangeNotifier {
  String first, last, email, phone, username, _profilePicture, _uid, bio;
  DateTime _created, _lastLogin;
  int _followersCount, _followingCount;
  FirebaseAuth _auth;

  UserModel(this._auth);

  Map<String, dynamic> toJson() => {
        'first': first,
        'last': last,
        'email': email,
        'phone': phone,
        'username': username,
        'profilePicture': _profilePicture,
        'bio': bio,
        'userID': _uid,
      };

  Future<bool> automaticSignIn() async {
    bool out = false;
    await _auth.currentUser().then((value) async {
      if (value != null) {
        await getUserData(value.uid).then((value) {
          if (value != null) {
            _setFieldsFromDatabase(value);
            out = true;
          }
        });
      }
    });
    return out;
  }

  void _setFieldsFromDatabase(Map<String, dynamic> json) {
    username = json['username'] as String;
    _uid = json['userkey'] as String;
    first = json['first_name'] as String;
    last = json['last_name'] as String;
    email = json['email'] as String;
    phone = json['phone'] as String;
    _profilePicture = json['profile_picture'] as String;
    _followingCount = json['following_count'] as int;
    _followersCount = json['follower_count'] as int;
  }

  Future<String> createUser(String p) async {
    FirebaseUser user;
    String errorMessage;

    try {
      AuthResult result =
          await _auth.createUserWithEmailAndPassword(email: email, password: p);
      user = result.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email is invalid.";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "This email already has an account.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }

    _uid = user.uid;
    _created = DateTime.now();
    _profilePicture =
        'https://www.jbrhomes.com/wp-content/uploads/blank-avatar.png';
    _followersCount = 0;
    _followingCount = 0;

    makeUser(this).then(
      (value) {
        if (value != 200) {
          _auth.currentUser().then((value) => value.delete());
          errorMessage = 'Could not make user.';
        }
      },
    );

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return 'good';
  }

  Future<String> signIn(String e, String p) async {
    FirebaseUser user;
    String errorMessage;

    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: e, password: p);
      user = result.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }

    _lastLogin = DateTime.now();
    _uid = user.uid;
    await getUserData(_uid).then((value) {
      if (value != null) {
        _setFieldsFromDatabase(value);
      } else {
        errorMessage = 'Could not get data from the database.';
      }
    });

    if (errorMessage != null) {
      return errorMessage;
    }
    
    return 'good';
  }

  String get dateCreated {
    return _created.toString();
  }

  String get userID {
    return _uid;
  }
}
