import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'crud.dart';

class VideosPage extends StatefulWidget {
  final bool isAdmin;

  const VideosPage({Key key, @required this.isAdmin}) : super(key: key);
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  // String videoId = YoutubePlayer.convertUrlToId(
  //     "https://www.youtube.com/watch?v=BBAyRBTfsOU");

  String url;
  bool isLive;
  //String videoId;
  YoutubePlayerController _controller;

  getUrl() async {
    String url;
    bool isLive;
    Firestore.instance
        .collection('video')
        .document('videoUrl')
        .get()
        .then((DocumentSnapshot ds) {
          setState(() {
            url = ds['URL'];
            isLive = ds['live'];
            print(url+isLive.toString());   
            _controller = YoutubePlayerController(
      initialVideoId: url,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: isLive,
      ),
    )..addListener(listener);   
          });
    });
    //return url;
  }

 
 

  @override
  void initState() {
    getUrl().then((value) {
      setState(() {
      
      print(url+" ghjk");
      
    });
    });
    
    
    super.initState();
  }

  
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
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
        centerTitle: true,
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
