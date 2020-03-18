import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/crud.dart';

class MakeAdmin extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  MakeAdmin(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _MakeAdminState createState() => _MakeAdminState();
}

class _MakeAdminState extends State<MakeAdmin> {
  TextEditingController controller = TextEditingController();
  String mail;
  String uid;
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Admin'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            controller: controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  makeAdmin();
                },
                child: Text('Add Admin'),
              ),
              SizedBox(
                width: 20,
              ),
              RaisedButton(
                onPressed: () {
                  removeAdmin();
                },
                child: Text('Remove Admin'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void makeAdmin() {
    mail = controller.text;
    Firestore.instance.collection('users').snapshots().listen((snapshot) {
      snapshot.documents.forEach((doc) {
        if (doc.data['Email'] == mail) {
          //doc.data['admin'] = true;
          uid = doc.data['uid'];
          name = doc.data['Name'];
          Crud().makeAdmin(name, mail, uid);
        }
      });
    });
  }

  void removeAdmin() {
    mail = controller.text;
    Firestore.instance.collection('users').snapshots().listen((snapshot) {
      snapshot.documents.forEach((doc) {
        if (doc.data['Email'] == mail) {
          //doc.data['admin'] = true;
          uid = doc.data['uid'];
          name = doc.data['Name'];
          Crud().removeAdmin(name, mail, uid);
        }
      });
    });
  }
}
