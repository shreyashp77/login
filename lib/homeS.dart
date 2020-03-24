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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: /*[Colors.orange.shade300, Colors.orange.shade800]*/ [
            Color(0xffFDC830),
            Color(0xfffc4a1a)
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(widget._user.photoUrl),
            radius: 70,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Welcome ${widget._user.displayName}!',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 15,
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
                } else if (snapshot.hasData) {
                  return checkRole(snapshot.data);
                }
                return LinearProgressIndicator();
              }),
        ],
      ),
    );
  }

  void addOnStart() {
    Crud().storeData(widget._user);
  }

  Widget checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text(
          'User not Found! Please Register first',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        ),
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
      child: OutlineButton(
        padding: EdgeInsets.symmetric(vertical: 15),
        borderSide: BorderSide(color: Colors.white),
        shape: StadiumBorder(),
        textColor: Colors.white,
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
        child: Text('Go to Admin Dashboard'),
      ),
    );
  }

  Widget userPage(DocumentSnapshot snapshot) {
    return Center(
      child: ButtonTheme(
        minWidth: 300,
        child: OutlineButton(
          padding: EdgeInsets.symmetric(vertical: 15),
          borderSide: BorderSide(color: Colors.white),
          shape: StadiumBorder(),
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NormalUsers(
                          widget._user,
                          widget._googleSignIn,
                        )));
          },
          child: Text('Go to Dashboard'),
        ),
      ),
    );
  }
}
