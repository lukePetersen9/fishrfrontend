class SimpleUser {
  String _first, _username, _profilePicture;

  SimpleUser(this._first, this._username, this._profilePicture);

  String get username {
    return _username;
  }

  String get firstName {
    return _first;
  }

  String get profilePicture {
    return _profilePicture;
  }
}
