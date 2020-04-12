import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  final TabController tabController;
  final int length;
  Indicator({this.tabController, this.length});

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 30,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: widget.tabController.index == index
                      ? Colors.white
                      : Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
