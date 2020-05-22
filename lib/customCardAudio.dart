import 'dart:io';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/audio.dart';

// import 'package:google_sign_in/google_sign_in.dart';

// import 'package:login/adminpage.dart';
import 'package:login/crud.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart' as Path;
import 'package:getflutter/getflutter.dart';

import 'msg.dart';

class CustomCardAudio extends StatefulWidget {
  BuildContext c1;
  // GoogleSignIn _googleSignIn;
  // FirebaseUser _user;

  CustomCardAudio({
    @required this.name,
    @required BuildContext context,
    @required this.url,
    this.isAdmin,
  }) {
    c1 = context;
  }

  final name;
  final url;
  final bool isAdmin;

  @override
  _CustomCardAudioState createState() => _CustomCardAudioState();
}

class _CustomCardAudioState extends State<CustomCardAudio> {
  int _changedNumber = 0, _selectedNumber = 0;

  final _fKey = GlobalKey<FormState>();

  _showAlertDialog(String desc) {
    showDialog<String>(
      context: widget.c1,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Delete?",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 40),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'No',
                            style: TextStyle(
                                color: Colors.red.shade400, fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        VerticalDivider(),
                        FlatButton(
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                          onPressed: () {
                            Crud().deleteAudioData(widget.name);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin == true) {
      return Slidable(
        actionExtentRatio: 0.25,
        child: Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(widget.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayAudio(
                        name: widget.name,
                        url: widget.url,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: 'Delete',
            color: Colors.redAccent,
            icon: Icons.delete,
            onTap: () {
              _showAlertDialog(widget.name);
              //Crud().deleteData(widget.topic);
            },
          ),
        ],
        actionPane: SlidableDrawerActionPane(),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(widget.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayAudio(
                      name: widget.name,
                      url: widget.url,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    }
  }
}
