import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'homeS.dart';
import 'crud.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email;
  String name;
  //String _email, _pass;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Signup'),
        ),
        // body: Form(
        //   key: _formKey,
        //   child: Column(
        //     children: <Widget>[
        //       TextFormField(
        //         validator: (input) {
        //           if (input.isEmpty) {
        //             return 'Email cannot be Empty!';
        //           }
        //         },
        //         onSaved: (input) => _email = input,
        //         decoration: InputDecoration(
        //           labelText: 'Email',
        //         ),
        //       ),
        //       TextFormField(
        //         validator: (input) {
        //           if (input.length < 6) {
        //             return 'Password too short!';
        //           }
        //         },
        //         onSaved: (input) => _pass = input,
        //         decoration: InputDecoration(
        //           labelText: 'Password',
        //         ),
        //         obscureText: true,
        //       ),
        //       RaisedButton(
        //         onPressed: () {
        //           signInWithGoogle().whenComplete(() {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                 builder: (context) {
        //                   return Welcome();
        //                 },
        //               ),
        //             );
        //           });
        //         },
        //         child: Text('Submit'),
        //       )
        //     ],
        //   ),
        // ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              // Future<FirebaseUser> user = signInWithGoogle();

              // signInWithGoogle().whenComplete(() {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) {
              //         return HomePage(user: user);
              //       },
              //     ),
              //   );
              // });

              onGoogleSignIn(context);
              // inputData(email, name);
              // Crud crud = Crud();
              // crud.addData({
              //   'Name': '${name}',
              //   'Email': '${email}',
              //   'admin': false,
              // });
            },
            child: Text('Google Sign-up'),
          ),
        ));
  }

  // Future<void> login() async {
  //   final formState = _formKey.currentState;
  //   if (formState.validate()) {
  //     formState.save();
  //     try {
  //       AuthResult user = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: _email, password: _pass);
  //       if (user.user.isEmailVerified) {
  //         // print(user.user.isEmailVerified);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => HomePage(
  //                       user: user,
  //                     )));
  //       } else {
  //         showD();
  //       }
  //     } catch (e) {
  //       print(e.message);
  //     }
  //   }
  // }

  // void showD() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Email not verified yet'),
  //           actions: <Widget>[
  //             FlatButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('OK')),
  //           ],
  //         );
  //       });
  // }

  // Future<FirebaseUser> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );

  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;

  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);

  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);

  //   return user;
  // }

  // void signOutGoogle() async {
  //   await googleSignIn.signOut();

  //   print("User Sign Out");
  // }

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
    Crud().getData().then((val) {
      if (val.documents.length > 0) {
        print(val.documents[user.uid].data["admin"]);
      } else {
        print("Not Found");
      }
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePageS(
                  user,
                  _googleSignIn,
                )));
  }
}
