import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/makeadmin.dart';
import 'package:login/picker.dart';
import 'package:path/path.dart' as Path;

import 'addaudio.dart';
import 'crud.dart';
import 'customCard.dart';
import 'message.dart';
import 'msg.dart';

//import 'normalusers.dart';

class AdminPage extends StatefulWidget {
  bool visible = false;
  bool isAdmin;

  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  AdminPage(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;
  TextEditingController topicInputController;
  TextEditingController descInputController;

  String sdate = "Not set";
  String stime = "Not set";
  String category = "none";

  //var topic;
  String imgUrl = "";

  final _fKey = GlobalKey<FormState>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // final TextEditingController taskTitleInputController =
  //     TextEditingController();
  // final TextEditingController taskDescripInputController =
  //     TextEditingController();
  // final TextEditingController topicInputController = TextEditingController();
  final List<Message> messages = [];

  File sampleImage;

  List<String> topics = const <String>[
    't1',
    't2',
    't3',
    't4',
  ];

  int _changedNumber = 0, _selectedNumber = 0;

  _showDialog() async {
    //String title = taskTitleInputController.text;
    //String body = taskDescripInputController.text;

    String topic = topicInputController.text;

    Future addEvent() async {
      String title = taskTitleInputController.text;
      String body = taskDescripInputController.text;
      String topic = topicInputController.text;
      String desc = descInputController.text;
      if (imgUrl.isNotEmpty)
        Crud().addEventData(title, body, topic, desc, sdate, stime, category,
            url: imgUrl);
      else
        Crud().addEventData(title, body, topic, desc, sdate, stime, category);
    }

    String convertTo12h(String hr, String mn) {
      int hrs = int.parse(hr);
      String ap;
      if (hrs > 12) {
        hrs = hrs - 12;
        ap = 'PM';
      } else if (hrs == 12) {
        ap = 'PM';
      } else if (hrs == 0) {
        hrs = 12;
        ap = 'AM';
      } else
        ap = 'AM';

      return (hrs.toString() + ':' + mn + ' ' + ap);
    }

    await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              //contentPadding: const EdgeInsets.all(16.0),
              content: Wrap(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Form(
                          key: _fKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                ),
                                controller: taskTitleInputController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Title cannot be empty!';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Body',
                                ),
                                controller: taskDescripInputController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Body cannot be empty!';
                                  }
                                  return null;
                                },
                              ),
                              //notUploaded(),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Topic',
                                ),
                                controller: topicInputController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Topic cannot be empty!';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                ),
                                controller: descInputController,
                                maxLines: null,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Description cannot be empty!';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),

                              //Upload(),

                              CupertinoButton(
                                //elevation: 7.0,
                                child: Text('Upload Image'),
                                //textColor: Colors.white,
                                color: Colors.orangeAccent,
                                onPressed: () {
                                  getImage().then((v) => setState(() {
                                        imgUrl = v;
                                      }));
                                },
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Category: '),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    //elevation: 4.0,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 200,
                                              color: Colors.white,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  CupertinoButton(
                                                    child: Text("Cancel"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: CupertinoPicker(
                                                      itemExtent: 32,
                                                      scrollController:
                                                          new FixedExtentScrollController(
                                                        initialItem:
                                                            _selectedNumber,
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      onSelectedItemChanged:
                                                          (int index) {
                                                        _changedNumber = index;
                                                      },
                                                      children:
                                                          List<Widget>.generate(
                                                              topics.length,
                                                              (int idx) {
                                                        return Center(
                                                          child: new Text(
                                                              topics[idx]),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  CupertinoButton(
                                                      child: Text("Ok"),
                                                      onPressed: () {
                                                        setState(() {
                                                          _selectedNumber =
                                                              _changedNumber;
                                                          category = topics[
                                                              _selectedNumber];
                                                        });
                                                        Navigator.pop(context);
                                                        print(category);
                                                      }),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      " $category",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // Text(
                                          //   "  Change",
                                          //   style: TextStyle(
                                          //       color: Colors.teal,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 15.0),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Date: '),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    //elevation: 4.0,
                                    onPressed: () {
                                      DatePicker.showDatePicker(
                                        context,
                                        theme: DatePickerTheme(
                                          containerHeight: 210.0,
                                        ),
                                        showTitleActions: true,
                                        minTime: DateTime.now(),
                                        maxTime: DateTime(2050, 12, 31),
                                        onConfirm: (date) {
                                          print('confirm $date');
                                          sdate =
                                              '${date.day} / ${date.month} / ${date.year}';
                                          setState(() {
                                            sdate =
                                                '${date.day} / ${date.month} / ${date.year}';
                                          });
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en,
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.date_range,
                                                      size: 15.0,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      " $sdate",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // Text(
                                          //   "  Change",
                                          //   style: TextStyle(
                                          //       color: Colors.teal,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 15.0),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('Time: '),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    //elevation: 4.0,
                                    onPressed: () {
                                      DatePicker.showTimePicker(context,
                                          theme: DatePickerTheme(
                                            containerHeight: 210.0,
                                          ),
                                          showTitleActions: true,
                                          showSecondsColumn: false,
                                          onConfirm: (time) {
                                        stime = convertTo12h(
                                            time.hour.toString(),
                                            time.minute.toString());

                                        //stime = '${time.hour} : ${time.minute}';
                                        setState(() {
                                          stime = convertTo12h(
                                              time.hour.toString(),
                                              time.minute.toString());
                                          // '${time.hour} : ${time.minute}';
                                        });
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.access_time,
                                                      size: 15.0,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      " $stime",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // Text(
                                          //   "  Change",
                                          //   style: TextStyle(
                                          //       color: Colors.teal,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 18.0),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FlatButton(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 15),
                                      ),
                                      onPressed: () {
                                        taskTitleInputController.clear();
                                        taskDescripInputController.clear();
                                        Navigator.pop(context);
                                      }),
                                  FlatButton(
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 15),
                                      ),
                                      onPressed: () async {
                                        if (_fKey.currentState.validate()) {
                                          Navigator.pop(context);
                                          await Future.delayed(
                                              const Duration(seconds: 5));
                                          addEvent();
                                          sendNotification();
                                          //enableUpload(/*topic*/);
                                          taskTitleInputController.clear();
                                          taskDescripInputController.clear();
                                          topicInputController.clear();
                                          descInputController.clear();
                                        }
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    taskTitleInputController = TextEditingController();
    taskDescripInputController = TextEditingController();
    topicInputController = TextEditingController();
    descInputController = TextEditingController();
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
      appBar: AppBar(
        title: Text('Administration Page'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
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
                    Text('Welcome ${widget._user.displayName}'),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget._user.photoUrl),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Add New Admin'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MakeAdmin(
                      widget._user,
                      widget._googleSignIn,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Add Audio Stream'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAudio(
                      widget._user,
                      widget._googleSignIn,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Upload Image'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                        //widget._user,
                        //widget._googleSignIn,
                        ),
                  ),
                );
              },
            ),
            //Divider(),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                widget._googleSignIn.signOut();
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('home'),
                );
              },
            ),
            //Divider(),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('notifications').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  return ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Card(
                        child: CustomCard(
                          title: document['Title'],
                          description: document['Body'],
                          topic: document['Topic'],
                          context: context,
                          isAdmin: true,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  // Widget Upload() {
  //   final StorageReference firebaseStorageRef = FirebaseStorage.instance
  //       .ref()
  //       .child('/events/${Path.basename(sampleImage.path)}');
  //   final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);
  //   if (task != null) {
  //     /// Manage the task state and event subscription with a StreamBuilder
  //     return StreamBuilder<StorageTaskEvent>(
  //         stream: task.events,
  //         builder: (_, snapshot) {
  //           var event = snapshot?.data?.snapshot;

  //           double progressPercent = event != null
  //               ? event.bytesTransferred / event.totalByteCount
  //               : 0;

  //           return Column(
  //             children: [
  //               if (task.isComplete) Text('F.ile uploaded!'),

  //               if (task.isPaused)
  //                 FlatButton(
  //                   child: Icon(Icons.play_arrow),
  //                   onPressed: task.resume,
  //                 ),

  //               if (task.isInProgress)
  //                 FlatButton(
  //                   child: Icon(Icons.pause),
  //                   onPressed: task.pause,
  //                 ),

  //               // Progress bar
  //               LinearProgressIndicator(value: progressPercent),
  //               Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
  //             ],
  //           );
  //         });
  //   } else {
  //     // Allows user to decide when to start the upload
  //     return RaisedButton(
  //       elevation: 7.0,
  //       child: Text('Browse Image'),
  //       textColor: Colors.white,
  //       color: Colors.orangeAccent,
  //       onPressed: () {
  //         getImage(task).then((v) => setState(() {
  //               imgUrl = v;
  //             }));
  //       },
  //     );
  //   }
  // }

  Future sendNotification() async {
    final response = await Messaging.sendToTopic(
        title: taskTitleInputController.text,
        body: taskDescripInputController.text,
        topic: category);

    // sendToAll(
    //   title: taskTitleInputController.text,
    //   body: taskDescripInputController.text,
    //   // fcmToken: fcmToken,
    // );

    if (response.statusCode != 200) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('[${response.statusCode}] Error message: ${response.body}'),
      ));
    }
  }

  void sendTokenToServer(String fcmToken) {
    print('Token: $fcmToken');
    // send key to your server to allow server to use
    // this token to send push notifications
  }

  Future<String> getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('/events/${Path.basename(sampleImage.path)}');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);

    if (task.isInProgress) CircularProgressIndicator();
    await task.onComplete;

    print('File Uploaded');
    final StorageTaskSnapshot downloadUrl = (await task.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    //print('URL Is $url');

    return url;
  }
}
