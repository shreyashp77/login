import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/demo.dart';
import 'package:login/donate.dart';
import 'package:login/editprofile.dart';
import 'package:login/viewvideo.dart';
// import 'package:login/picker.dart';

// import 'addevent.dart';
import 'aboutus.dart';
import 'audiolist.dart';
import 'contactus.dart';
import 'customCard.dart';
// import 'makeadmin.dart';
import 'message.dart';
import 'msg.dart';
import 'subscriptions.dart';

class NormalUsers extends StatefulWidget {
  bool visible = false;
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  NormalUsers(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _NormalUsersState createState() => _NormalUsersState();
}

class _NormalUsersState extends State<NormalUsers> {
  dynamic data;

  Future<dynamic> getUserName() async {
    final DocumentReference document =
        Firestore.instance.collection("users").document(widget._user.uid);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data = snapshot.data;
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;
  TextEditingController topicInputController;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final List<Message> messages = [];

  @override
  void initState() {
    taskTitleInputController = TextEditingController();
    taskDescripInputController = TextEditingController();
    topicInputController = TextEditingController();
    getUserName();

    super.initState();

    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();

    //_firebaseMessaging.subscribeToTopic('all');

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(
          () {
            messages.add(
              Message(
                // title: notification['title'],
                // body: notification['body'],
                title: '${notification['title']}',
                body: '${notification['body']}',
              ),
            );
          },
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          elevation: 0.5,
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(top: 22),
              child: FaIcon(
                FontAwesomeIcons.gopuram,
                color: Colors.black,
              ),
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: Color(0xfffdfcfa),
          title: Padding(
            padding: const EdgeInsets.only(top: 34),
            child: Text(
              'Hare Krishna!',
              textScaleFactor: 1.7,
              style: GoogleFonts.courgette(
                textStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 75,
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Welcome " + data['Name'] + "!"),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget._user.photoUrl),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.solidBell,
                size: 25.0,
              ),
              title: Text('Subscriptions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Subscriptions(
                        //widget._user,
                        //widget._googleSignIn,
                        ),
                  ),
                );
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.prayingHands,
                size: 23.0,
              ),
              title: Text('View Daily Darshan'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Demo(
                        //widget._user,
                        //widget._googleSignIn,
                        ),
                  ),
                );
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.podcast,
                size: 28.0,
              ),
              title: Text('View Audio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioList(
                      isAdmin: false,
                      //widget._user,
                      //widget._googleSignIn,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideosPage(
                      isAdmin: false,
                        ),
                  ),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.youtube,
                size: 23.0,
              ),
              title: Text('Latest Video'),
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.userEdit,
                size: 28.0,
              ),
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(
                        //isAdmin: false,
                        //widget._user,
                        //widget._googleSignIn,
                        ),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: FaIcon(
            //     FontAwesomeIcons.plus,
            //     size: 23.0,
            //   ),
            //   title: Text('Post Queries'),
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (context) => PostQuery(
            //     //         widget._user,
            //     //         widget._googleSignIn,
            //     //         ),
            //     //   ),
            //     // );
            //   },
            // ),
            Divider(
              thickness: 0.5,
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Donation(
            //             //widget._user,
            //             //widget._googleSignIn,
            //             ),
            //       ),
            //     );
            //   },
            //   leading: FaIcon(
            //     FontAwesomeIcons.rupeeSign,
            //     size: 25.0,
            //   ),
            //   title: Text('Donate'),
            // ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.solidEnvelope,
                size: 23.0,
              ),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactScreen(
                        //widget._user,
                        //widget._googleSignIn,
                        ),
                  ),
                );
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.infoCircle,
                size: 23.0,
              ),
              title: Text('About ISKCON'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(
                        //widget._user,
                        //widget._googleSignIn,
                        ),
                  ),
                );
              },
            ),
            Divider(
              thickness: 0.5,
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.signOutAlt,
                size: 23.0,
              ),
              title: Text('Logout'),
              onTap: () {
                widget._googleSignIn.signOut();
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('home'),
                );
              },
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('notifications')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');
              default:
                return ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return Card(
                      color: Color(0xffffffff),
                      child: CustomCard(
                        title: document['Title'],
                        description: document['Body'],
                        //topic: document['Topic'],
                        context: context,
                        isAdmin: false,
                        ndate: document['Date'],
                        stime: document['Time'],
                        url: document['URL'],
                        desc: document['Description'],
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  Future sendNotification() async {
    final response = await Messaging.sendToAll(
      title: taskTitleInputController.text,
      body: taskDescripInputController.text,
      // fcmToken: fcmToken,
    );

    if (response.statusCode != 200) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content:
              Text('[${response.statusCode}] Error message: ${response.body}'),
        ),
      );
    }
  }

  void sendTokenToServer(String fcmToken) {
    print('Token: $fcmToken');
    // send key to your server to allow server to use
    // this token to send push notifications
  }
}
