import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/makeadmin.dart';

import 'addevent.dart';
import 'crud.dart';
import 'customCard.dart';

//import 'normalusers.dart';

class AdminPage extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  AdminPage(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int len;

  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;
  TextEditingController topicInputController;

  @override
  initState() {
    taskTitleInputController = TextEditingController();
    taskDescripInputController = TextEditingController();
    topicInputController = TextEditingController();
    super.initState();
  }

  _showDialog() async {
    String title = taskTitleInputController.text;
    String body = taskDescripInputController.text;
    String topic = topicInputController.text;

    await showDialog<String>(
      context: context,
      child: AlertDialog(
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
              child: TextField(
                decoration: InputDecoration(labelText: 'Notification Topic'),
                controller: topicInputController,
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                taskTitleInputController.clear();
                taskDescripInputController.clear();
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Add'),
              onPressed: () {
                if (taskDescripInputController.text.isNotEmpty &&
                    taskTitleInputController.text.isNotEmpty) {
                  //Crud().addEventData(title, body, topic);
                  Firestore.instance
                      .collection('notifications')
                      .document(topic)
                      .setData({
                    "Title": taskTitleInputController.text,
                    "Body": taskDescripInputController.text,
                    "Topic": topicInputController.text
                  });
                  Navigator.pop(context);
                  taskTitleInputController.clear();
                  taskDescripInputController.clear();
                }
              })
        ],
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   totalLength().then((result) {
  //     setState(() {
  //       len = result;
  //     });
  //   });
  //   print(len);
  // }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document['Title']),
      subtitle: Text(document['Body']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administration Page'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 75,
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Welcome ${widget._user.displayName}'),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget._user.photoUrl),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Add Event'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEvent()));
              },
            ),
            ListTile(
              title: Text('Edit/Delete Event'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Add/Remove Admin'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MakeAdmin(
                              widget._user,
                              widget._googleSignIn,
                            )));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('notifications').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  return ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return CustomCard(
                        title: document['Title'],
                        description: document['Body'],
                        topic: document['Topic'],
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<int> totalLength() async {
    var respectsQuery = Firestore.instance.collection('notifications');
    //.where('postID', isEqualTo: postID);
    var querySnapshot = await respectsQuery.getDocuments();
    var totalEquals = querySnapshot.documents.length;
    return totalEquals;
  }
}

/*
Center(
              child: RaisedButton(
                onPressed: () {
                  widget._googleSignIn.signOut();
                  Navigator.pop(context);
                },
                child: Text('Logout'),
              ),
            ),
 */
