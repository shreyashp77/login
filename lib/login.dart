import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'homeL.dart';
import 'crud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email;
  String name;
  //String _email, _pass;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      child: Center(
        child: ButtonTheme(
          minWidth: 300,
          child: OutlineButton(
            shape: StadiumBorder(),
            textColor: Colors.white,
            borderSide: BorderSide(color: Colors.white),
            onPressed: () {
              onGoogleSignIn(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.googlePlusG),
                SizedBox(width: 10),
                Text('Login'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    // hold the instance of the authenticated user
    FirebaseUser user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      // if so, return the current user
      user = await _auth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      user = (await _auth.signInWithCredential(credential)).user;
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser user = await _handleSignIn();
    Crud().getData().then(
      (val) {
        if (val.documents.length > 0) {
          print(val.documents[user.uid].data["admin"]);
        } else {
          print("Not Found");
        }
      },
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePageL(
          user,
          _googleSignIn,
        ),
      ),
    );
  }
}
