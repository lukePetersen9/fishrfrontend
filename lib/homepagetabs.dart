import 'package:flutter/material.dart';
import 'package:sample/Models/user.dart';
import 'package:sample/makepost.dart';
import 'package:sample/messages.dart';
import 'package:sample/publicpage.dart';
import 'package:sample/search.dart';
import 'package:sample/userprofile.dart';
import 'yourPage.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePageTabs extends StatefulWidget {
  final User model;
  HomePageTabs(this.model);
  @override
  _HomePageTabsState createState() => _HomePageTabsState();
}

class _HomePageTabsState extends State<HomePageTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool show = false;

  @override
  void initState() {
    super.initState();
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
        child: ScopedModel<User>(
          model: widget.model,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MakePostPage(widget.model.userID),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                size: 40,
              ),
            ),
            drawer: Drawer(
              child: ScopedModelDescendant<User>(
                builder: (context, widget, model) {
                  return ListView(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(model.profilePicture),
                          ),
                        ),
                      ),
                      Text(model.firstName),
                      Text(model.username),
                      FlatButton(
                        onPressed: () {},
                        child:
                            Text(model.followerCount.toString() + ' followers'),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                            model.followingCount.toString() + ' following'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfile(model.userID),
                            ),
                          );
                        },
                        child: Text('Your profile'),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text('Settings'),
                      ),
                    ],
                  );
                },
              ),
            ),
            bottomNavigationBar: Container(
              color: Colors.grey[800],
              height: 70,
              child: TabBar(
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    child: Icon(
                      Icons.home,
                    ),
                  ),
                  Tab(
                    child: Icon(Icons.blur_on),
                  ),
                  Tab(
                    child: Icon(
                      Icons.search,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.message,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.blue[200],
            body: ScopedModelDescendant<User>(
              builder: (context, widget, model) {
                return TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    YourPage(model),
                    PublicPage(model),
                    SearchPage(model),
                    Messages(model),
                  ],
                );
              },
            ),
          ),
        ),
        onWillPop: () async {
          return true;
        },
      ),
    );
  }
}
