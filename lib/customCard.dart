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
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Text("Please enter the details"),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Notification Title'),
                controller: taskTitleInputController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Notification Body'),
                controller: taskDescripInputController,
              ),
            ),
            Expanded(
              child: Text(topic),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                // if (taskDescripInputController.text.isNotEmpty &&
                //     taskTitleInputController.text.isNotEmpty) {
                //   taskTitleInputController.clear();
                //   taskDescripInputController.clear();
                // }

                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Edit'),
              onPressed: () {
                if (taskDescripInputController.text.isNotEmpty &&
                    taskTitleInputController.text.isNotEmpty) {
                  editEvent(topic);
                  sendNotification();
                  Navigator.pop(context);
                  taskTitleInputController.clear();
                  taskDescripInputController.clear();
                }
              })
        ],
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
              Crud().deleteData(widget.topic);
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
