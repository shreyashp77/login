import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/crud.dart';

class HomePage extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  HomePage(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            Center(
              child: RaisedButton(
                onPressed: () {
                  widget._googleSignIn.signOut();
                  Navigator.pop(context);
                },
                child: Text('Logout'),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  //make admin
                },
                child: Text('Make Admin'),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('users')
                    .document(widget._user.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error : ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading...');
                    default:
                      return checkRole(snapshot.data);
                  }
                })
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

  Center checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data['admin'] == true)
      return adminPage(snapshot);
    else
      return userPage(snapshot);
  }

  Center adminPage(DocumentSnapshot snapshot) {
    return Center(child: Text('Admin'));
  }

  Center userPage(DocumentSnapshot snapshot) {
    return Center(child: Text('Not Admin'));
  }
}
