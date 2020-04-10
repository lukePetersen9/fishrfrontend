import 'package:flutter/material.dart';
import 'package:sample/homepagetabs.dart';
import 'yourPage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'user.dart';

class LoginSignUp extends StatefulWidget {
  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _username, _password;
  bool show = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _username = TextEditingController();
    _password = TextEditingController();
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
        length: 2,
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
                    onPressed: () {},
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
                        child: Text('Sign Up'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white54),
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'first name',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration:
                            InputDecoration.collapsed(hintText: 'last name'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration:
                            InputDecoration.collapsed(hintText: 'phone number'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
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
                        child: ScopedModel<User>(
                          model: User.init(_username.text, _password.text,
                              makeUser: true),
                          child: Column(
                            children: [
                              ScopedModelDescendant<User>(
                                builder: (context, widget, model) {
                                  return FlatButton(
                                    child: Text('sign up'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomePageTabs(model),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 5),
                                  );
                                },
                              ),
                            ],
                          ),
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
