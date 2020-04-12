import 'package:flutter/material.dart';
import 'package:sample/Models/user.dart';

class Messages extends StatefulWidget {
  final User data;
  Messages(this.data);
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextField(
            decoration: InputDecoration.collapsed(
              hintText: 'Messages',
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return true;
      },
    );
  }
}
