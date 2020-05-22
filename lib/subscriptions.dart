import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getflutter/getflutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Subscriptions extends StatefulWidget {
  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final GlobalKey<ScaffoldState> sk = new GlobalKey<ScaffoldState>();
  bool isExpanded = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  bool isExpanded4 = false;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static SharedPreferences _sharedPreferences;

  //bool _isChecked = _sharedPreferences.getBool("check") ?? false;

  bool value1;
  bool value2;
  bool value3;
  bool value4;

  _loadswitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      value1 = (prefs.getBool('counter1')) ?? false;
      value2 = (prefs.getBool('counter2')) ?? false;
      value3 = (prefs.getBool('counter3')) ?? false;
      value4 = (prefs.getBool('counter4')) ?? false;
    });
  }

  _savenswitchValue1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('counter1', value1);
    });
  }

  _savenswitchValue2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('counter2', value2);
    });
  }

  _savenswitchValue3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('counter3', value3);
    });
  }

  _savenswitchValue4() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('counter4', value4);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadswitchValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sk,
      appBar: AppBar(
        title: Text(
          'Subscriptions',
          style: TextStyle(color: Colors.black),
          //textScaleFactor: 1.2,
        ),
        centerTitle: true,
        backgroundColor: Color(0xfffdfcfa),
        //backgroundColor: Colors.white,
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
        children: <Widget>[
          // Card(
          //   child: ListTile(
          //     title: Text('Topic 1'),
          //     trailing: ButtonBar(
          //       mainAxisSize: MainAxisSize.min,
          //       children: <Widget>[
          //         ButtonTheme(
          //           child: RaisedButton(
          //             onPressed: () {
          //               sk.currentState.showSnackBar(
          //                 SnackBar(
          //                   content: Text('Operation Successful!'),
          //                   duration: Duration(seconds: 3),
          //                 ),
          //               );
          //             },
          //             child: Row(
          //               children: <Widget>[
          //                 Icon(FontAwesomeIcons.check),
          //                 Text('   YES'),
          //               ],
          //             ),
          //           ),
          //         ),
          //         ButtonTheme(
          //           child: RaisedButton(
          //             onPressed: () {
          //               sk.currentState.showSnackBar(
          //                 SnackBar(
          //                   content: Text('Operation Successful!'),
          //                   duration: Duration(seconds: 3),
          //                 ),
          //               );
          //             },
          //             child: Row(
          //               children: <Widget>[
          //                 Icon(FontAwesomeIcons.times),
          //                 Text('   NO'),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          //   Card(
          //     child: ExpansionTile(
          //       title: Text(
          //         'Topic 1',
          //         style: TextStyle(
          //             color: isExpanded ? Colors.orangeAccent : Colors.black),
          //       ),
          //       onExpansionChanged: (bool x) {
          //         setState(() {
          //           this.isExpanded = x;
          //         });
          //       },
          //       children: <Widget>[
          //         ButtonBar(
          //           mainAxisSize: MainAxisSize.max,
          //           children: <Widget>[
          //             FlatButton(
          //               child: Text(
          //                 'Unsubscribe',
          //                 style: TextStyle(color: Colors.redAccent),
          //               ),
          //               onPressed: () {
          //                 sk.currentState.showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Unsubscribed!',
          //                     ),
          //                     duration: Duration(seconds: 3),
          //                   ),
          //                 );
          //                 _firebaseMessaging.unsubscribeFromTopic('t1');
          //               },
          //             ),
          //             FlatButton(
          //               child: Text('Subscribe'),
          //               onPressed: () {
          //                 sk.currentState.showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Subscribed!',
          //                     ),
          //                     duration: Duration(seconds: 3),
          //                   ),
          //                 );
          //                 _firebaseMessaging.subscribeToTopic('t1');
          //               },
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),

          //   Card(
          //     child: ExpansionTile(
          //       title: Text(
          //         'Topic 2',
          //         style: TextStyle(
          //             color: isExpanded2 ? Colors.orangeAccent : Colors.black),
          //       ),
          //       onExpansionChanged: (bool x) {
          //         setState(() {
          //           this.isExpanded2 = x;
          //         });
          //       },
          //       children: <Widget>[
          //         ButtonBar(
          //           mainAxisSize: MainAxisSize.max,
          //           children: <Widget>[
          //             FlatButton(
          //               child: Text(
          //                 'Unsubscribe',
          //                 style: TextStyle(color: Colors.redAccent),
          //               ),
          //               onPressed: () {
          //                 sk.currentState.showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Unsubscribed!',
          //                     ),
          //                     duration: Duration(seconds: 3),
          //                   ),
          //                 );
          //                 _firebaseMessaging.unsubscribeFromTopic('t2');
          //               },
          //             ),
          //             FlatButton(
          //               child: Text('Subscribe'),
          //               onPressed: () {
          //                 sk.currentState.showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Subscribed!',
          //                     ),
          //                     duration: Duration(seconds: 3),
          //                   ),
          //                 );
          //                 _firebaseMessaging.subscribeToTopic('t2');
          //               },
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),

          //   Card(
          //     child: ExpansionTile(
          //       title: Text(
          //         'Topic 3',
          //         style: TextStyle(
          //             color: isExpanded3 ? Colors.orangeAccent : Colors.black),
          //       ),
          //       onExpansionChanged: (bool x) {
          //         setState(() {
          //           this.isExpanded3 = x;
          //         });
          //       },
          //       children: <Widget>[
          //         ButtonBar(
          //           mainAxisSize: MainAxisSize.max,
          //           children: <Widget>[
          //             FlatButton(
          //               child: Text(
          //                 'Unsubscribe',
          //                 style: TextStyle(color: Colors.redAccent),
          //               ),
          //               onPressed: () {
          //                 sk.currentState.showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Unsubscribed!',
          //                     ),
          //                     duration: Duration(seconds: 3),
          //                   ),
          //                 );
          //                 _firebaseMessaging.unsubscribeFromTopic('t3');
          //               },
          //             ),
          //             FlatButton(
          //               child: Text('Subscribe'),
          //               onPressed: () {
          //                 sk.currentState.showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Subscribed!',
          //                     ),
          //                     duration: Duration(seconds: 3),
          //                   ),
          //                 );
          //                 _firebaseMessaging.subscribeToTopic('t3');
          //               },
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),

          //   Card(
          //     child: ExpansionTile(
          //       title: Text(
          //         'Topic 4',
          //         style: TextStyle(
          //             color: isExpanded4 ? Colors.orangeAccent : Colors.black),
          //       ),
          //       onExpansionChanged: (bool x) {
          //         setState(() {
          //           this.isExpanded4 = x;
          //         });
          //       },
          //       children: <Widget>[
          //         ButtonBar(
          //           mainAxisSize: MainAxisSize.max,
          //           children: <Widget>[
          //             FlatButton(
          //               child: Text(
          //                 'Unsubscribe',
          //                 style: TextStyle(color: Colors.redAccent),
          //               ),
          //               onPressed: () {
          //                 sk.currentState.showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Unsubscribed!',
          //                     ),
          //                     duration: Duration(seconds: 3),
          //                   ),
          //                 );
          //                 _firebaseMessaging.unsubscribeFromTopic('t4');
          //               },
          //             ),
          //             FlatButton(
          //               child: Text('Subscribe'),
          //               onPressed: () {
          //                 sk.currentState.showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       'Subscribed!',
          //                     ),
          //                     duration: Duration(seconds: 3),
          //                   ),
          //                 );
          //                 _firebaseMessaging.subscribeToTopic('t4');
          //               },
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),

          MergeSemantics(
            child: ListTile(
              title: Text('Topic 1'),
              trailing: CupertinoSwitch(
                activeColor: Colors.blue,
                value: value1,
                onChanged: (bool value) {
                  setState(() {
                    value1 = value;
                    _savenswitchValue1();
                  });
                  if (value1) {
                    _firebaseMessaging.subscribeToTopic('t1');
                  } else
                    _firebaseMessaging.unsubscribeFromTopic('t1');
                },
              ),
              onTap: () {
                setState(() {
                  value1 = !value1;
                });
              },
            ),
          ),

          MergeSemantics(
            child: ListTile(
              title: Text('Topic 2'),
              trailing: CupertinoSwitch(
                activeColor: Colors.blue,
                value: value2,
                onChanged: (bool value) {
                  setState(() {
                    value2 = value;
                    _savenswitchValue2();
                  });

                  if (value2) {
                    _firebaseMessaging.subscribeToTopic('t2');
                  } else
                    _firebaseMessaging.unsubscribeFromTopic('t2');
                },
              ),
              onTap: () {
                setState(() {
                  value2 = !value2;
                });
              },
            ),
          ),

          MergeSemantics(
            child: ListTile(
              title: Text('Topic 3'),
              trailing: CupertinoSwitch(
                activeColor: Colors.blue,
                value: value3,
                onChanged: (bool value) {
                  setState(() {
                    value3 = value;
                    _savenswitchValue3();
                  });

                  if (value3) {
                    _firebaseMessaging.subscribeToTopic('t3');
                  } else
                    _firebaseMessaging.unsubscribeFromTopic('t3');
                },
              ),
              onTap: () {
                setState(() {
                  value3 = !value3;
                });
              },
            ),
          ),

          MergeSemantics(
            child: ListTile(
              title: Text('Topic 4'),
              trailing: CupertinoSwitch(
                activeColor: Colors.blue,
                value: value4,
                onChanged: (bool value) {
                  setState(() {
                    value4 = value;
                    _savenswitchValue4();
                  });

                  if (value4) {
                    _firebaseMessaging.subscribeToTopic('t4');
                  } else
                    _firebaseMessaging.unsubscribeFromTopic('t4');
                },
              ),
              onTap: () {
                setState(() {
                  value4 = !value4;
                });
              },
            ),
          ),

          // CheckboxListTile(
          //   value: _checkboxValueB,
          //   onChanged: (bool value) async {
          //     setState(() {
          //       _checkboxValueB = value;
          //       _savenswitchValue();
          //     });
          //   },
          //   title: Text("CheckBox Text"),
          // ),
        ],
      ),
    );
  }
}
