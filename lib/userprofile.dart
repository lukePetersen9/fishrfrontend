import 'package:flutter/material.dart';
import 'package:sample/Models/currentuser.dart';
import 'package:sample/backendServices/Express/databasemethods.dart';

class UserProfile extends StatefulWidget {
  final String userID;
  UserProfile(this.userID);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  CurrentUser profile;
  bool loaded;
  @override
  void initState() {
    super.initState();
    profile = CurrentUser.init(widget.userID);
    _tabController = TabController(vsync: this, length: 3);
    loaded = false;
    // getUserData(widget.userID).then((value) {
    //   print(value);
    //   if (value != null) {
    //     setState(() {
    //       //profile = value;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(profile.profilePicture),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(profile.first),
                        Text(profile.last),
                        Text(profile.username),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('${profile.followersCount} followers'),
                  Text('${profile.followingCount} following'),
                ],
              ),
            ),
            Expanded(
              flex: 18,
              child: DefaultTabController(
                length: 3,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Center(
                      child: Text('posts'),
                    ),
                    ListView.builder(
                      itemCount: profile.repostedCardsListLength,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('post');
                      },
                    ),
                    Center(
                      child: Text('likeposts'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
