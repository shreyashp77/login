import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NormalUsers extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  NormalUsers(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _NormalUsersState createState() => _NormalUsersState();
}

class _NormalUsersState extends State<NormalUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            widget._googleSignIn.signOut();
            Navigator.popUntil(context, ModalRoute.withName('home'));
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
