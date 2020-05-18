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
  final snackBar = SnackBar(content: Text('Email cannot be empty!'));
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Admin',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfffdfcfa),
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
                          content: Text('Please enter a valid email!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      makeAdmin();
                      controller.clear();
                      //Navigator.pop(context);
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Operation Successful!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Add Admin',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              // RaisedButton(
              //   onPressed: () {
              //     removeAdmin();
              //   },
              //   child: Text('Remove Admin'),
              // ),
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

  // void removeAdmin() {
  //   mail = controller.text;
  //   Firestore.instance.collection('users').snapshots().listen((snapshot) {
  //     snapshot.documents.forEach((doc) {
  //       if (doc.data['Email'] == mail) {
  //         //doc.data['admin'] = true;
  //         uid = doc.data['uid'];
  //         name = doc.data['Name'];
  //         Crud().removeAdmin(name, mail, uid);
  //       }
  //     });
  //   });
  // }
}
