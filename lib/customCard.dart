import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/adminpage.dart';
import 'package:login/crud.dart';
import 'editpage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'msg.dart';

class CustomCard extends StatefulWidget {
  BuildContext c1;
  // GoogleSignIn _googleSignIn;
  // FirebaseUser _user;

  CustomCard(
      {@required this.title,
      @required this.description,
      @required this.topic,
      @required BuildContext context,
      @required this.isAdmin}) {
    c1 = context;
  }

  final title;
  final description;
  final topic;
  final bool isAdmin;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;

  final _fKey = GlobalKey<FormState>();

  _showEditDialog(String topic) async {
    //String title = taskTitleInputController.text;
    //String body = taskDescripInputController.text;
    //String topic = topicInputController.text;

    Future editEvent(String topic) async {
      String title = taskTitleInputController.text;
      String body = taskDescripInputController.text;
      //String topic = topicInputController.text;

      Crud().addEventData(title, body, topic);
    }

    await showDialog<String>(
      context: widget.c1,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        //contentPadding: const EdgeInsets.all(16.0),
        content: Container(
          //height: 218,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Form(
                key: _fKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                      controller: taskTitleInputController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Body',
                      ),
                      controller: taskDescripInputController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Body cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red.shade400),
                          ),
                          onPressed: () {
                            if (taskDescripInputController.text.isNotEmpty &&
                                taskTitleInputController.text.isNotEmpty) {
                              taskTitleInputController.clear();
                              taskDescripInputController.clear();
                            }
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 10),
                        FlatButton(
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.blue.shade400),
                          ),
                          onPressed: () {
                            if (_fKey.currentState.validate()) {
                              editEvent(topic);
                              sendNotification();
                              Navigator.pop(context);
                              taskTitleInputController.clear();
                              taskDescripInputController.clear();
                            }
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

  _showAlertDialog(/*String topic*/) {
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
                      "Delete the event?",
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
                            style: TextStyle(
                                color: Colors.blue.shade400, fontSize: 15),
                          ),
                          onPressed: () {
                            Crud().deleteData(widget.topic);
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
  void initState() {
    taskTitleInputController = TextEditingController();
    taskDescripInputController = TextEditingController();
    super.initState();
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
                title: Text(widget.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.description),
                    Text('ghello'),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DescriptionPage(
                          title: widget.title,
                          description: widget.description,
                          topic: widget.topic),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        actions: <Widget>[
          new IconSlideAction(
            caption: 'Edit',
            color: Colors.blue,
            icon: Icons.edit,
            onTap: () {
              _showEditDialog(widget.topic);
            },
          ),
        ],
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              _showAlertDialog();
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
              title: Text(widget.title),
              subtitle: Text(widget.description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                        title: widget.title,
                        description: widget.description,
                        topic: widget.topic),
                  ),
                );
              },
            )
          ],
        ),
      );
    }
  }

  Future sendNotification() async {
    final response = await Messaging.sendToAll(
      title: taskTitleInputController.text,
      body: taskDescripInputController.text,
      // fcmToken: fcmToken,
    );

    if (response.statusCode != 200) {
      Scaffold.of(widget.c1).showSnackBar(SnackBar(
        content:
            Text('[${response.statusCode}] Error message: ${response.body}'),
      ));
    }
  }
}
