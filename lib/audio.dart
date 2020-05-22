import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PlayAudio extends StatefulWidget {
  final name;
  final url;

  const PlayAudio({Key key, @required this.name, @required this.url})
      : super(key: key);
  @override
  _PlayAudioState createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  final _volumeSubject = BehaviorSubject.seeded(1.0);
  final _speedSubject = BehaviorSubject.seeded(1.0);
  AudioPlayer _player;
  String u;
  //"https://firebasestorage.googleapis.com/v0/b/login-demo-8c251.appspot.com/o/audio%2Fwii.mp3?alt=media&token=705a2fe5-4c67-428d-bdb9-f3db7faa9090";

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setUrl(widget.url).catchError((error) {
      // catch audio error ex: 404 url, wrong url ...
      print(error);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black),
          //textScaleFactor: 1.2,
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<FullAudioPlaybackState>(
              stream: _player.fullPlaybackStateStream,
              builder: (context, snapshot) {
                final fullState = snapshot.data;
                final state = fullState?.state;
                final buffering = fullState?.buffering;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state == AudioPlaybackState.connecting ||
                        buffering == true)
                      Container(
                        margin: EdgeInsets.all(8.0),
                        width: 64.0,
                        height: 64.0,
                        child: CircularProgressIndicator(),
                      )
                    else if (state == AudioPlaybackState.playing)
                      IconButton(
                        icon: Icon(Icons.pause),
                        iconSize: 64.0,
                        onPressed: _player.pause,
                      )
                    else
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        iconSize: 64.0,
                        onPressed: _player.play,
                      ),
                    IconButton(
                      icon: Icon(Icons.stop),
                      iconSize: 64.0,
                      onPressed: state == AudioPlaybackState.stopped ||
                              state == AudioPlaybackState.none
                          ? null
                          : _player.stop,
                    ),
                  ],
                );
              },
            ),
            Text("Track position"),
            StreamBuilder<Duration>(
              stream: _player.durationStream,
              builder: (context, snapshot) {
                final duration = snapshot.data ?? Duration.zero;
                return StreamBuilder<Duration>(
                  stream: _player.getPositionStream(),
                  builder: (context, snapshot) {
                    var position = snapshot.data ?? Duration.zero;
                    if (position > duration) {
                      position = duration;
                    }
                    return SeekBar(
                      duration: duration,
                      position: position,
                      onChangeEnd: (newPosition) {
                        _player.seek(newPosition);
                      },
                    );
                  },
                );
              },
            ),
            Text("Volume"),
            StreamBuilder<double>(
              stream: _volumeSubject.stream,
              builder: (context, snapshot) => Slider(
                divisions: 10,
                min: 0.0,
                max: 2.0,
                value: snapshot.data ?? 1.0,
                onChanged: (value) {
                  _volumeSubject.add(value);
                  _player.setVolume(value);
                },
              ),
            ),
            Text("Speed"),
            StreamBuilder<double>(
              stream: _speedSubject.stream,
              builder: (context, snapshot) => Slider(
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: snapshot.data ?? 1.0,
                onChanged: (value) {
                  _speedSubject.add(value);
                  _player.setSpeed(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0.0,
      max: widget.duration.inMilliseconds.toDouble(),
      value: _dragValue ?? widget.position.inMilliseconds.toDouble(),
      onChanged: (value) {
        setState(() {
          _dragValue = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged(Duration(milliseconds: value.round()));
        }
      },
      onChangeEnd: (value) {
        _dragValue = null;
        if (widget.onChangeEnd != null) {
          widget.onChangeEnd(Duration(milliseconds: value.round()));
        }
      },
    );
  }
}
