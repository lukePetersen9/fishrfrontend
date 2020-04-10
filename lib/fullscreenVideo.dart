import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
/*
Master Password for database:  zmZMGOOIqHV7t4cP0VBV
 */

class FullscreenVideo extends StatefulWidget {
  final VideoPlayerController controller;
  FullscreenVideo(this.controller);

  @override
  _FullscreenVideoState createState() => _FullscreenVideoState();
}

class _FullscreenVideoState extends State<FullscreenVideo> {
  ScrollController scrollController;
  double offset = 60;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(
      () {
        if (scrollController.offset <= -150 &&
            scrollController.position.outOfRange) {
          scrollController.dispose();
          HapticFeedback.mediumImpact();
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = widget.controller.value.size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          widget.controller.value.initialized
              ? Container(
                  width: size.width,
                  height: size.height,
                  child: new VideoPlayer(widget.controller),
                )
              : Container(
                  child: CircularProgressIndicator(),
                ),
          ListView.builder(
            controller: scrollController,
            itemCount: 40,
            itemBuilder: (BuildContext context, int index) {
              return index == 0 || index == 39
                  ? FlatButton(
                      onPressed: () {
                        !widget.controller.value.isPlaying
                            ? widget.controller.play()
                            : widget.controller.pause();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                      ),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Text(
                        index.toString() + ' This is a comment!!!',
                        style: TextStyle(fontSize: 20, color: Colors.white60),
                      ),
                    );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).viewInsets.bottom > 1
                    ? MediaQuery.of(context).viewInsets.bottom + 55
                    : 60),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38,
                ),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Comment',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30,right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                iconSize: 50,
                color: Colors.blue,
                icon: Icon(Icons.fullscreen_exit),
                onPressed: () {
                  scrollController.dispose();
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
