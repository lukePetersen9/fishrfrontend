import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/backendServices/Express/databasemethods.dart';
import 'package:sample/homepagetabs.dart';

import 'Models/currentuser.dart';

class LoginSignUp extends StatefulWidget {
  LoginSignUp();
  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _username, _password, _email, _first, _last, _phone;
  bool show = false;
  String userId = 'hello';
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _auth.currentUser().then((value) {
      if (value != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageTabs(CurrentUser.init(value.uid)),
          ),
        );
      }
    });
    _tabController = TabController(vsync: this, length: 3);
    _username = TextEditingController();
    _password = TextEditingController();
    _email = TextEditingController();
    _first = TextEditingController();
    _last = TextEditingController();
    _phone = TextEditingController();
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
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: DefaultTabController(
        length: 3,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      _tabController.animateTo(1);
                    },
                    child: Text('Sign Up'),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      _tabController.animateTo(2);
                    },
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.blue[200],
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FlatButton(
                          onPressed: () {
                            _tabController.animateTo(0);
                          },
                          child: Text('back'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Text(userId),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white54),
                        child: TextField(
                          controller: _first,
                          decoration: InputDecoration.collapsed(
                            hintText: 'first name',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _last,
                        decoration:
                            InputDecoration.collapsed(hintText: 'last name'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _phone,
                        decoration:
                            InputDecoration.collapsed(hintText: 'phone number'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _email,
                        decoration:
                            InputDecoration.collapsed(hintText: 'email'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _username,
                        decoration:
                            InputDecoration.collapsed(hintText: 'username'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _password,
                        decoration:
                            InputDecoration.collapsed(hintText: 'password'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: 'retype password'),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Column(
                          children: [
                            FlatButton(
                              child: Text('sign up'),
                              onPressed: () async {
                                setState(() {
                                  show = true;
                                });
                                print('pressed');
                                await _auth
                                    .createUserWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text)
                                    .then(
                                  (value) async {
                                    print(value);
                                    if (value != null) {
                                      CurrentUser user = CurrentUser.init(
                                        value.user.uid,
                                        username: _username.text,
                                        first: _first.text,
                                        last: _last.text,
                                        phone: _phone.text,
                                        e: _email.text,
                                      );
                                      print(user.toJson());
                                      makeUser(user).then(
                                        (value) {
                                          print(value);
                                          if (value == 200) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePageTabs(user),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                            ),
                            show ? CircularProgressIndicator() : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.blue[200],
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FlatButton(
                          onPressed: () {
                            _tabController.animateTo(0);
                          },
                          child: Text('back'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Text('Login'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _email,
                        decoration:
                            InputDecoration.collapsed(hintText: 'email'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _password,
                        decoration:
                            InputDecoration.collapsed(hintText: 'password'),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Column(
                          children: [
                            FlatButton(
                              child: Text('login'),
                              onPressed: () async {
                                setState(() {
                                  show = true;
                                });
                                _auth
                                    .signInWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text)
                                    .then((value) {
                                  setState(() {
                                    if (value.user.uid == null) {
                                      setState(() {
                                        show = false;
                                      });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePageTabs(
                                              new CurrentUser.init(
                                                  value.user.uid)),
                                        ),
                                      );
                                    }
                                  });
                                });
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                            ),
                            show ? CircularProgressIndicator() : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
