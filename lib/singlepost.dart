import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class SinglePost extends StatefulWidget {
  final Function setImage, setVideo;
  SinglePost(this.setImage, this.setVideo);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost>
    with AutomaticKeepAliveClientMixin<SinglePost> {
  List<Widget> tabs = new List<Widget>();
  VideoPlayerController _controller;
  File _image;
  bool _play = false;

  Future getImage() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((value) {
      setState(() {
        _image = value;
        widget.setImage(_image);
      });
    });
  }

  Future getVideo() async {
    await ImagePicker.pickVideo(
      source: ImageSource.camera,
    ).then((value) {
      _controller = VideoPlayerController.file(value)
        ..initialize().then(
          (_) {
            setState(
              () {
                _controller.setLooping(true);
                widget.setVideo(value.path);
              },
            );
          },
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AspectRatio(
      aspectRatio: 487 / 451,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (!_play && _image == null) {
              getImage();
            } else if (!_play && _image != null) {
              if (_controller != null) {
                _controller.play();
              }
              _play = !_play;
            } else if (_play && _controller == null) {
              getVideo();
            } else if (_play && _controller != null) {
              _controller.pause();
              _play = !_play;
            }
          });
        },
        child: display(),
      ),
    );
  }

  Widget display() {
    if (!_play && _image == null) {
      return Center(
        child: Icon(Icons.camera),
      );
    } else if (!_play && _image != null) {
      return Container(
        child: Image.file(_image),
      );
    } else if (_play && _controller == null) {
      return Center(
        child: Icon(Icons.videocam),
      );
    } else {
      return ClipRect(
        child: new OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          alignment: Alignment.center,
          child: new FittedBox(
            fit: BoxFit.cover,
            alignment: Alignment.center,
            child: new Container(
              width: _controller.value.size.width / 2,
              height: _controller.value.size.height / 2,
              child: new VideoPlayer(_controller),
            ),
          ),
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
