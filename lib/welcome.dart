import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/login.dart';
import 'package:login/signup.dart';
import 'package:random_color/random_color.dart';

import 'crud.dart';
import 'homeL.dart';

class Welcome extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor1 = RandomColor();
    Color _color1 = _randomColor1.randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorHue: ColorHue.multiple(colorHues: <ColorHue>[ColorHue.blue]));

    MyColor _myColor1 = getColorNameFromColor(_color1);
    print(_myColor1.getName);

    RandomColor _randomColor2 = RandomColor();
    Color _color2 = _randomColor2.randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorHue: ColorHue.multiple(colorHues: <ColorHue>[ColorHue.red]));
    MyColor _myColor2 = getColorNameFromColor(_color2);
    print(_myColor2.getName);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: /*[Colors.orange.shade300, Colors.orange.shade800]*/ [
            //Color(0xffFC354C),
            //Color(0xff0ABFBC),
            //Color(0xff514A9D),
            _color1,
            _color2

            //BEST
            //Color(0xffFC354C),
            //Color(0xff514A9D),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/logo.png'),
              height: 200,
              width: 200,
            ),
            ButtonTheme(
              minWidth: 300,
              child: OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: StadiumBorder(),
                textColor: Colors.white,
                borderSide: BorderSide(color: Colors.white),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Login(),
                  //       fullscreenDialog: true,
                  //     ));
                  onGoogleSignIn(context);
                },
                child: Text('Login'),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     print("onTap called.");
            //   },
            //   child: Text(
            //     "Not a member yet? Click here to Register",
            //     style: TextStyle(
            //       decoration: TextDecoration.underline,
            //       color: Colors.grey.shade900,
            //       fontSize: 15,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 8,
            ),
            ButtonTheme(
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
                        builder: (context) => Signup(),
                        fullscreenDialog: true,
                      ));
                  //onGoogleSignIn(context);
                },
                child: Text('Signup'),
              ),
            ),
            // RaisedButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => Signup(),
            //         ));
            //   },
            //   child: Text('Signup'),
            // ),
          ],
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
