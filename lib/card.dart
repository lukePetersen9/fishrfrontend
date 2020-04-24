import 'package:flutter/material.dart';
import 'package:sample/Models/singlecard.dart';
import 'Models/currentuser.dart';
import 'indicator.dart';
import 'picturevid.dart';

class CustomCard extends StatefulWidget {
  final SingleCard data;
  final CurrentUser user;
  CustomCard(this.data, this.user);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  List<Widget> tabs = new List<Widget>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: ((widget.data.picturesAndVideos.indexOf(null)+1)/2).floor());
    _tabController.addListener(() {
      setState(() {});
    });
    for (int i = 0; widget.data.picturesAndVideos[i] != null; i += 2) {
      tabs.add(
        PictureVideo(widget.data.picturesAndVideos[i],
            widget.data.picturesAndVideos[i + 1]),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.data.title),
        AspectRatio(
          aspectRatio: 487 / 451,
          child: Stack(
            children: <Widget>[
              DefaultTabController(
                length: 2,
                child: TabBarView(controller: _tabController, children: tabs),
              ),
              Indicator(
                tabController: _tabController,
                length: 2,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.data.toggleLike();
                      });
                    },
                    icon: Icon(
                      widget.data.liked()
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 30,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
        Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.data.numberOfLikes.toString() + ' likes'),
                  Text(widget.data.postedBy)
                ],
              ),
            ),
            Expanded(
              child: Align(
                child: Text(
                  widget.data.postedOn,
                ),
                alignment: Alignment.centerRight,
              ),
            )
          ],
        ),
        Text(
          widget.data.description,
        ),
        Divider()
      ],
    );
  }
}
