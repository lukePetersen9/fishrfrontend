import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class PictureVideo extends StatefulWidget {
  final String pic, vid;
  PictureVideo(this.pic, this.vid);

  @override
  _PictureVideoState createState() => _PictureVideoState();
}

class _PictureVideoState extends State<PictureVideo> {
  bool show = false;

  VideoPlayerController _controller;
  Duration time = new Duration();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.vid)
      ..initialize().then((_) {
        _controller.setLooping(true);
        time = _controller.value.duration;
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = _controller.value.size;
    return GestureDetector(
      onTap: () {
        setState(() {
          show = !show;
          show ? _controller.play() : _controller.pause();
        });
      },
      child: show
          ? _controller.value.initialized
              ? Stack(
                  children: <Widget>[
                    ClipRect(
                      child: new OverflowBox(
                        maxWidth: double.infinity,
                        maxHeight: double.infinity,
                        alignment: Alignment.center,
                        child: new FittedBox(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          child: new Container(
                            width: size.width,
                            height: size.height,
                            child: new VideoPlayer(_controller),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {},
                          ),
                          Text(
                            time.inSeconds.toString() + ' seconds',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                  ],
                )
              : Container(
                  child: CircularProgressIndicator(),
                )
          : Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.center,
                  image: NetworkImage(
                    widget.pic.trim(),
                  ),
                ),
              ),
            ),
    );
  }
}
