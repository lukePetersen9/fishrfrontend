import 'package:flutter/material.dart';
import 'package:sample/Models/currentuser.dart';
import 'card.dart';

class YourPage extends StatelessWidget {
  final CurrentUser data;
  YourPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.id),
        automaticallyImplyLeading: false,
      ),
      body: 
      ListView.builder(
        itemCount: data.privateCardListLength,
        itemBuilder: (BuildContext context, int index) {
          return CustomCard(data.privateCards[index], data);
        },
      ),
    );
  }
}
