import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:http/http.dart' as http;
import 'package:login/crud.dart';

class AddVideo extends StatefulWidget {
  AddVideo() : super();

  final String title = 'Add Video';

  @override
  AddVideoState createState() => AddVideoState();
}

class AddVideoState extends State<AddVideo> {
  String url = "";

  TextEditingController controller = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.title,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              autofocus: true,
              controller: controller,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'Youtube Video URL',
                labelStyle: TextStyle(color: Colors.orangeAccent),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 250,
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  //borderSide: BorderSide(color: Colors.black),
                  color: Colors.blue,
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('URL cannot be Empty!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      url = controller.text;
                      Crud().addVideoUrl(url);
                      controller.clear();
                      //Navigator.pop(context);
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('URL Added!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Add Video',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
