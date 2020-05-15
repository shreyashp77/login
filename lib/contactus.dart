import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(color: Colors.black),
          textScaleFactor: 1.2,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: FaIcon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Card(
            elevation: 0.7,
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: '+918411845000'));
                    Toast.show("Number copied to clipboard", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                  title: Text('Phone Number : '),
                  subtitle: Text('+91 8411845000'),
                  trailing: Icon(Icons.phone),
                ),
              ],
            ),
          ),
          Card(
            elevation: 0.7,
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: 'nvcc@iskconpune.in'));
                    Toast.show("Email copied to clipboard", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                  title: Text('Email : '),
                  subtitle: Text('nvcc@iskconpune.in'),
                  trailing: Icon(Icons.alternate_email),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
