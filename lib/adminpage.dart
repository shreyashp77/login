import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/makeadmin.dart';

import 'addevent.dart';

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
      body: Column(
        children: <Widget>[],
      ),
    );
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
