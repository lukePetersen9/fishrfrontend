import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/backendServices/Express/databasemethods.dart';
import 'package:sample/loginsignup.dart';
import 'package:sample/makepost.dart';
import 'package:sample/messages.dart';
import 'package:sample/publicpage.dart';
import 'package:sample/search.dart';
import 'package:sample/userprofile.dart';
import 'Models/currentuser.dart';
import 'yourPage.dart';

class HomePageTabs extends StatefulWidget {
  final CurrentUser user;
  HomePageTabs(this.user);
  @override
  _HomePageTabsState createState() => _HomePageTabsState();
}

class _HomePageTabsState extends State<HomePageTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool show = false;
  CurrentUser _user;

  @override
  void initState() {
    super.initState();
    _user = CurrentUser.init(widget.user.id);
    getCompleteUserData(_user).then((value) {
      if (value != null) {
        setState(() {});
      }
    });
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('sdfs');
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MakePostPage(widget.user.id),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 40,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_user.profilePicture),
                    ),
                  ),
                ),
                Text(_user.first),
                Text(_user.username),
                FlatButton(
                  onPressed: () {},
                  child: Text(_user.followersCount.toString() + ' followers'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(_user.followingCount.toString() + ' following'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(widget.user.id, null),
                      ),
                    );
                  },
                  child: Text('Your profile'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('Settings'),
                ),
                FlatButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginSignUp(),
                        ),
                      );
                    });
                  },
                  child: Text('Log Out'),
                ),
              ],
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
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              YourPage(_user),
              PublicPage(_user),
              SearchPage(_user),
              Messages(_user),
            ],
          ),
        ),
        onWillPop: () async {
          return true;
        },
      ),
    );
  }
}
