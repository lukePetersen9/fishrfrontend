import 'package:flutter/material.dart';
import 'package:sample/yourPage.dart';
import 'user.dart';
import 'databasemethods.dart';

class DatabaseInterface extends StatelessWidget {
  final User data;
  DatabaseInterface(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.userID),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
