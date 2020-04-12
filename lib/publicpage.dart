import 'package:flutter/material.dart';
import 'package:sample/Models/singlecard.dart';
import 'package:sample/Models/user.dart';
import 'card.dart';

class PublicPage extends StatelessWidget {
  final User data;
  PublicPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return CustomCard(
                  SingleCard(
                    t: 'hello buddy',
                    desc: 'This is the ' + index.toString() + ' card',
                    pb: 'me',
                    po: index.toRadixString(10),
                  ),
                  this.data);
            },
          ),
        ],
      ),
    );
  }
}
