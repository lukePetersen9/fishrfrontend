import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'dart:convert';

class Post {
  List<String> _encodedImages;
  List<String> _encodedVideos;
  String _title, _description;
  DateTime _time;

  Post() {
    this._title = '';
    _description = '';
    _time = null;
    _encodedImages = new List<String>();
    _encodedVideos = new List<String>();
  }

  void image1(String image) async {
    await io.File(image).readAsBytes().then(
      (value) {
        _encodedImages[0] = base64Encode(value);
      },
    );
  }

  void image2(String image) async {
    await io.File(image).readAsBytes().then(
      (value) {
        _encodedImages[1] = base64Encode(value);
      },
    );
  }

  void image3(String image) async {
    await io.File(image).readAsBytes().then(
      (value) {
        _encodedImages[2] = base64Encode(value);
      },
    );
  }

  void image4(String image) async {
    await io.File(image).readAsBytes().then(
      (value) {
        _encodedImages[3] = base64Encode(value);
      },
    );
  }

  void video1(String image) async {
    await io.File(image).readAsBytes().then(
      (value) {
        _encodedImages[0] = base64Encode(value);
      },
    );
  }

  void video2(String image) async {
    await io.File(image).readAsBytes().then(
      (value) {
        _encodedImages[1] = base64Encode(value);
      },
    );
  }

  void video3(String image) async {
    await io.File(image).readAsBytes().then(
      (value) {
        _encodedImages[2] = base64Encode(value);
      },
    );
  }

  void video4(String image) async {
    await io.File(image).readAsBytes().then(
      (value) {
        _encodedImages[3] = base64Encode(value);
      },
    );
  }

  Map<String, dynamic> toJson() => {
        'image1': _encodedImages[0],
        'image2': _encodedImages[1],
        'image3': _encodedImages[2],
        'image4': _encodedImages[3],
        'title': _title,
        'description': _description,
      };
}
