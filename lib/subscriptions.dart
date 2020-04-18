import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sk,
      appBar: AppBar(
        title: Text('Subscriptions'),
        backgroundColor: Colors.orangeAccent,
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
          Card(
            child: ExpansionTile(
              title: Text(
                'Topic 1',
                style: TextStyle(
                    color: isExpanded ? Colors.orangeAccent : Colors.black),
              ),
              onExpansionChanged: (bool x) {
                setState(() {
                  this.isExpanded = x;
                });
              },
              children: <Widget>[
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Unsubscribe',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      onPressed: () {
                        sk.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Unsubscribed!',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        _firebaseMessaging.unsubscribeFromTopic('t1');
                      },
                    ),
                    FlatButton(
                      child: Text('Subscribe'),
                      onPressed: () {
                        sk.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Subscribed!',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        _firebaseMessaging.subscribeToTopic('t1');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Card(
            child: ExpansionTile(
              title: Text(
                'Topic 2',
                style: TextStyle(
                    color: isExpanded2 ? Colors.orangeAccent : Colors.black),
              ),
              onExpansionChanged: (bool x) {
                setState(() {
                  this.isExpanded2 = x;
                });
              },
              children: <Widget>[
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Unsubscribe',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      onPressed: () {
                        sk.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Unsubscribed!',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        _firebaseMessaging.unsubscribeFromTopic('t2');
                      },
                    ),
                    FlatButton(
                      child: Text('Subscribe'),
                      onPressed: () {
                        sk.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Subscribed!',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        _firebaseMessaging.subscribeToTopic('t2');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Card(
            child: ExpansionTile(
              title: Text(
                'Topic 3',
                style: TextStyle(
                    color: isExpanded3 ? Colors.orangeAccent : Colors.black),
              ),
              onExpansionChanged: (bool x) {
                setState(() {
                  this.isExpanded3 = x;
                });
              },
              children: <Widget>[
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Unsubscribe',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      onPressed: () {
                        sk.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Unsubscribed!',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        _firebaseMessaging.unsubscribeFromTopic('t3');
                      },
                    ),
                    FlatButton(
                      child: Text('Subscribe'),
                      onPressed: () {
                        sk.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Subscribed!',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        _firebaseMessaging.subscribeToTopic('t3');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Card(
            child: ExpansionTile(
              title: Text(
                'Topic 4',
                style: TextStyle(
                    color: isExpanded4 ? Colors.orangeAccent : Colors.black),
              ),
              onExpansionChanged: (bool x) {
                setState(() {
                  this.isExpanded4 = x;
                });
              },
              children: <Widget>[
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Unsubscribe',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      onPressed: () {
                        sk.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Unsubscribed!',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        _firebaseMessaging.unsubscribeFromTopic('t4');
                      },
                    ),
                    FlatButton(
                      child: Text('Subscribe'),
                      onPressed: () {
                        sk.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Subscribed!',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        _firebaseMessaging.subscribeToTopic('t4');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
