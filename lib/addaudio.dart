//import 'package:audioplayer/audioplayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:chewie_audio/chewie_audio.dart';
import 'package:url_audio_stream/url_audio_stream.dart';

class AddAudio extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  AddAudio(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _AddAudioState createState() => _AddAudioState();
}

class _AddAudioState extends State<AddAudio> {
  //String url = 'https://www.w3schools.com/tags/horse.mp3';

  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  static AudioStream stream =
      new AudioStream("https://www.w3schools.com/tags/horse.mp3");
  Future<void> callAudio(String action) async {
    if (action == "start") {
      stream.start();
    } else if (action == "stop") {
      stream.stop();
    } else if (action == "pause") {
      stream.pause();
    } else {
      stream.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text("Start"),
              onPressed: () {
                callAudio("start");
              },
            ),
            new RaisedButton(
              child: new Text("Stop"),
              onPressed: () {
                callAudio("stop");
              },
            ),
            new RaisedButton(
              child: new Text("Pause"),
              onPressed: () {
                callAudio("pause");
              },
            ),
            new RaisedButton(
              child: new Text("Resume"),
              onPressed: () {
                callAudio("resume");
              },
            )
          ],
        )),
      ),
    );
  }
}
