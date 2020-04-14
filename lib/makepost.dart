import 'package:flutter/material.dart';
import 'package:sample/backendServices/Express/databasemethods.dart';
import 'package:sample/singlepost.dart';

import 'Models/post.dart';

class MakePostPage extends StatefulWidget {
  MakePostPage();
  @override
  _MakePostPageState createState() => _MakePostPageState();
}

class _MakePostPageState extends State<MakePostPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Post _post;

  @override
  void initState() {
    super.initState();
    _post = new Post();
    _tabController = TabController(vsync: this, length: 4);
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
            title: Text('Image Picker Example'),
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
                      SinglePost(_post.image1),
                      SinglePost(_post.image2),
                      SinglePost(_post.image3),
                      SinglePost(_post.image4),
                    ],
                  ),
                ),
                TextField(
                  decoration: InputDecoration.collapsed(hintText: 'Title'),
                ),
                TextField(
                  decoration:
                      InputDecoration.collapsed(hintText: 'Description'),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('object');
              sendPost(_post).then(
                (value) {
                  print(value);
                  if (value == 200) {
                    Navigator.pop(context);
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
