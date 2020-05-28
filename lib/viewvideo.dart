import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  // String videoId = YoutubePlayer.convertUrlToId(
  //     "https://www.youtube.com/watch?v=BBAyRBTfsOU");

  String url;
  String videoId;
  YoutubePlayerController _controller;

  @override
  void initState() {
    Firestore.instance
        .collection('video')
        .document('videoUrl')
        .get()
        .then((DocumentSnapshot ds) {
      url = ds['URL'];
      videoId = YoutubePlayer.convertUrlToId(url);
    });
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Latest Videos',
          style: TextStyle(color: Colors.black),
          textScaleFactor: 1.2,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: FaIcon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: YoutubePlayer(
        controller: _controller,
        aspectRatio: 18 / 9,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onReady: () {
          print('ready');
        },
      ),
    );
  }
}
