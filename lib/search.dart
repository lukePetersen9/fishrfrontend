import 'package:flutter/material.dart';
import 'package:sample/Models/user.dart';

class SearchPage extends StatefulWidget {
  final User data;
  SearchPage(this.data);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextField(
            decoration: InputDecoration.collapsed(
              hintText: 'Search...',
            ),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return FlatButton(
              onPressed: () {},
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.data.profilePicture),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(widget.data.firstName),
                      Text(widget.data.username),
                    ],
                  ),
                  Container(
                    color: Colors.green,
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: Colors.blue[200],
      ),
      onWillPop: () async {
        return true;
      },
    );
  }
}
