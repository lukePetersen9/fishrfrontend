import 'package:flutter/material.dart';
import 'package:sample/backendServices/Express/databasemethods.dart';
import 'package:sample/singlepost.dart';

import 'Models/post.dart';

class MakePostPage extends StatefulWidget {
  final String _userID;
  MakePostPage(this._userID);
  @override
  _MakePostPageState createState() => _MakePostPageState();
}

class _MakePostPageState extends State<MakePostPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _titleController, _descriptionController;
  TabController _tabController;
  Post _post;
  String i = 'sdfas';

  @override
  void initState() {
    super.initState();
    _post = new Post(widget._userID);
    _tabController = TabController(vsync: this, length: 4);
    _titleController = new TextEditingController();
    _descriptionController = new TextEditingController();
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(i),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 600,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      SinglePost(_post.image1, _post.video1),
                      SinglePost(_post.image2, _post.video2),
                      SinglePost(_post.image3, _post.video3),
                      SinglePost(_post.image4, _post.video4),
                    ],
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration.collapsed(hintText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration:
                      InputDecoration.collapsed(hintText: 'Description'),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('pressed');
              _post.setTitle(_titleController.text);
              _post.setDescription(_descriptionController.text);
              setState(() {
                i = 'posting...';
              });
              sendPost(_post).then(
                (value) {
                  if (value == 200) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      i = 'something went wrong:/';
                    });
                  }
                },
              );

              //
            },
            child: Icon(Icons.screen_share),
          ),
        ),
        onWillPop: () async {
          return true;
        },
      ),
    );
  }
}
