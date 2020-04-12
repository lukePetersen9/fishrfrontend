import 'package:flutter/material.dart';
import 'card.dart';
import 'user.dart';

class YourPage extends StatelessWidget {
  final User data;
  YourPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.userID),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: data.privateCardListLength,
        itemBuilder: (BuildContext context, int index) {
          return CustomCard(
            data.privateCardList[index],
            data
          );
        },
      ),
    );
  }
}
