import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/signup.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
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
            RaisedButton(
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
