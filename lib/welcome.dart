import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/signup.dart';

class Welcome extends StatelessWidget {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                        fullscreenDialog: true,
                      ));
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
}
