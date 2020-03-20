import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/crud.dart';
import 'package:login/normalusers.dart';

import 'adminpage.dart';

class HomePageS extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  HomePageS(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _HomePageSState createState() => _HomePageSState();
}

class _HomePageSState extends State<HomePageS> {
  @override
  void initState() {
    addOnStart();
    super.initState();
  }

  AsyncSnapshot<DocumentSnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome ${widget._user.displayName}'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('users')
                    .document(widget._user.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error : ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return checkRole(snapshot.data);
                  }
                  return LinearProgressIndicator();
                }),
          ],
        ));
  }

  void addOnStart() {
    Crud().storeData(widget._user
        //'Name': widget._user.displayName,
        // 'Email': widget._user.email,
        // 'admin': false

        );
  }

  Widget checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text('NO Data Found!'),
      );
    }
    if (snapshot.data['admin'] == true) {
      return adminPage(snapshot);
    } else {
      return userPage(snapshot);
    }
  }

  Widget adminPage(DocumentSnapshot snapshot) {
    return Center(
      // child: Text('${snapshot.data['role']} ${snapshot.data['name']}'));
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(
                widget._user,
                widget._googleSignIn,
              ),
            ),
          );
        },
        child: Text('Go to admins page'),
      ),
    );
  }

  Widget userPage(DocumentSnapshot snapshot) {
    // return Center(child: Text(snapshot.data['name']));
    return Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NormalUsers(
                        widget._user,
                        widget._googleSignIn,
                      )));
        },
        child: Text('Go to user page'),
      ),
    );
  }
}
