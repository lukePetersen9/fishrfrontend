import 'package:flutter/material.dart';
import 'package:sample/Models/currentuser.dart';
import 'package:sample/userprofile.dart';
import 'backendServices/Express/databasemethods.dart';

class SearchPage extends StatefulWidget {
  final CurrentUser data;
  SearchPage(this.data);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<CurrentUser> searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = new List<CurrentUser>();
  }

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
            onChanged: (s) {
              if (s.isNotEmpty) {
                searchText(s).then((value) {
                  setState(() {
                    if (value != null) {
                      searchResults = value;
                    }
                  });
                });
              } else {
                emptySearchList().then((value) {
                  setState(() {
                    if (value != null) {
                      searchResults = value;
                    }
                  });
                });
              }
            },
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: FlatButton(
                color: Colors.grey[200],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserProfile(searchResults[index].id),
                    ),
                  );
                },
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage(searchResults[index].profilePicture),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            '${searchResults[index].first} ${searchResults[index].last}'),
                        Text('${searchResults[index].username}'),
                      ],
                    ),
                  ],
                ),
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
