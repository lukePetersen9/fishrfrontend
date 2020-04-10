import 'package:flutter/material.dart';
import 'package:sample/singlecard.dart';
import 'package:scoped_model/scoped_model.dart';
import 'indicator.dart';
import 'picturevid.dart';
import 'user.dart';
/*
Master Password for database:  zmZMGOOIqHV7t4cP0VBV
 */

/*Hello */
class CustomCard extends StatefulWidget {
  final SingleCard data;
  final User user;
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
    _tabController =
        TabController(vsync: this, length: widget.data.pictures.length);
    _tabController.addListener(() {
      setState(() {});
    });
    for (int i = 0; i < widget.data.pictures.length; i++) {
      tabs.add(
        PictureVideo(
            widget.data.pictures[i], widget.data.videos[0]),
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
                length: widget.data.pictures.length,
                child: TabBarView(controller: _tabController, children: tabs),
              ),
              Indicator(
                tabController: _tabController,
                length: 2,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ScopedModel<SingleCard>(
                  model: widget.data,
                  child: IconButton(
                    onPressed: () {
                      print('like ' + widget.data.title);
                      widget.data.toggleLike();
                    },
                    icon: ScopedModelDescendant<SingleCard>(
                      builder: (context, widget, model) {
                        return Icon(
                          model.liked()
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 30,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ),
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
