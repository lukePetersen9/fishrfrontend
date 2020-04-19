import 'package:flutter/material.dart';
import 'package:sample/Models/singlecard.dart';
import 'package:sample/Models/currentuser.dart';
import 'card.dart';

class PublicPage extends StatelessWidget {
  final CurrentUser data;
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
            itemCount: data.publicCardListLength,
            itemBuilder: (BuildContext context, int index) {
              return CustomCard(data.publicCards[index], this.data);
            },
          ),
        ],
      ),
    );
  }
}
