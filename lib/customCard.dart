import 'dart:io';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:login/adminpage.dart';
import 'package:login/crud.dart';
import 'editpage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart' as Path;
import 'package:getflutter/getflutter.dart';

import 'msg.dart';

class CustomCard extends StatefulWidget {
  BuildContext c1;
  // GoogleSignIn _googleSignIn;
  // FirebaseUser _user;

  CustomCard(
      {@required this.title,
      @required this.description,
      //@required this.topic,
      @required BuildContext context,
      @required this.isAdmin,
      @required this.ndate,
      @required this.stime,
      this.url,
      @required this.desc}) {
    c1 = context;
  }

  final title;
  final description;
  //final topic;
  final bool isAdmin;
  final ndate;
  final stime;
  final url;
  final desc;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;
  TextEditingController descInputController;

  String sdate = "Not set";
  String stime = "Not set";

  List<String> topics = const <String>[
    't1',
    't2',
    't3',
    't4',
  ];

  int _changedNumber = 0, _selectedNumber = 0;

  String imgUrl = "";

  File sampleImage;

  String category = "none";

  final _fKey = GlobalKey<FormState>();

  _showEditDialog(String topic) async {
    //String title = taskTitleInputController.text;
    //String body = taskDescripInputController.text;
    //String topic = topicInputController.text;

    Future editEvent(String topic) async {
      String title = taskTitleInputController.text;
      String body = taskDescripInputController.text;
      String desc = descInputController.text;
      //String topic = topicInputController.text;
      //print('title : ' + title);
      //if (title.isNotEmpty) Crud().editEventData(topic, title: title);
      // if (body != null) Crud().editEventData(topic, body: body);
      // if (sdate != 'Not set') Crud().editEventData(topic, sdate: sdate);
      // if (stime != 'Not set') Crud().editEventData(topic, stime: stime);
      // Crud().editEventData(topic, url: 'asdf.com');

      // Crud().editEventData(topic,
      //     title: title, body: body, sdate: sdate, stime: stime);
      if (imgUrl.isNotEmpty)
        Crud().addEventData(title, body, desc, sdate, stime, category,
            url: imgUrl);
      else
        Crud().addEventData(title, body, desc, sdate, stime, category);
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

      if (int.parse(mn) < 10) mn = '0' + mn;

      return (hrs.toString() + ':' + mn + ' ' + ap);
    }

    await showDialog<String>(
        context: widget.c1,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              //contentPadding: const EdgeInsets.all(16.0),
              content: Wrap(
                children: <Widget>[
                  Container(
                    //height: 218,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Form(
                          key: _fKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                //autofocus: true,
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
                              // SizedBox(height: 15),
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
                              SizedBox(height: 15),
                              CupertinoButton(
                                //elevation: 7.0,
                                child: Text('Upload Image'),
                                //textColor: Colors.white,
                                color: Colors.blue,
                                onPressed: () {
                                  getImage().then((v) => setState(() {
                                        imgUrl = v;
                                      }));
                                },
                              ),

                              SizedBox(
                                height: 15,
                              ),

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
                                      DatePicker.showDatePicker(context,
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
                                          locale: LocaleType.en);
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
                              // SizedBox(
                              //   height: 10.0,
                              // ),
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
                                          showSecondsColumn: false,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        stime = convertTo12h(
                                            time.hour.toString(),
                                            time.minute.toString());
                                        setState(() {
                                          stime = convertTo12h(
                                              time.hour.toString(),
                                              time.minute.toString());
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
                              // SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'Cancel',
                                      style:
                                          TextStyle(color: Colors.red.shade400),
                                    ),
                                    onPressed: () {
                                      if (taskDescripInputController
                                              .text.isNotEmpty &&
                                          taskTitleInputController
                                              .text.isNotEmpty) {
                                        taskTitleInputController.clear();
                                        taskDescripInputController.clear();
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  FlatButton(
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      if (_fKey.currentState.validate()) {
                                        Crud().deleteData(widget.desc);
                                        editEvent(widget.desc);
                                        sendNotification();
                                        Navigator.pop(context);
                                        taskTitleInputController.clear();
                                        taskDescripInputController.clear();
                                      }
                                    },
                                  ),
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
          });
        });
  }

  _showAlertDialog(String desc) {
    showDialog<String>(
      context: widget.c1,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Delete the event?",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 40),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'No',
                            style: TextStyle(
                                color: Colors.red.shade400, fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        VerticalDivider(),
                        FlatButton(
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                          onPressed: () {
                            //Crud().deleteData(widget.desc);
                            Crud().deleteData(widget.desc);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    taskTitleInputController = TextEditingController();
    taskDescripInputController = TextEditingController();
    descInputController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin == true) {
      return Slidable(
        actionExtentRatio: 0.25,
        child: Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: GFAvatar(
                  shape: GFAvatarShape.standard,
                  size: 40,
                  //radius: 25,
                  backgroundImage: NetworkImage(widget.url),
                ),
                title: Text(widget.title),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.ndate),
                    Text(widget.stime),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DescriptionPage(
                        title: widget.title,
                        description: widget.description,
                        //topic: widget.topic,
                        ndate: widget.ndate,
                        stime: widget.stime,
                        url: widget.url,
                        desc: widget.desc,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        actions: <Widget>[
          new IconSlideAction(
            caption: 'Edit',
            color: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            onTap: () {
              _showEditDialog(widget.desc);
            },
          ),
        ],
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: 'Delete',
            color: Colors.redAccent,
            icon: Icons.delete,
            onTap: () {
              _showAlertDialog(widget.desc);
              //Crud().deleteData(widget.topic);
            },
          ),
        ],
        actionPane: SlidableDrawerActionPane(),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: GFAvatar(
                shape: GFAvatarShape.standard,
                size: 40,
                //radius: 25,
                backgroundImage: NetworkImage(widget.url),
              ),
              title: Text(widget.title),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.ndate),
                  Text(widget.stime),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      title: widget.title,
                      description: widget.description,
                      //topic: widget.topic,
                      ndate: widget.ndate,
                      stime: widget.stime,
                      url: widget.url,
                      desc: widget.desc,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    }
  }

  Future sendNotification() async {
    final response = await Messaging.sendToTopic(
        title: taskTitleInputController.text,
        body: taskDescripInputController.text,
        topic: category);

    if (response.statusCode != 200) {
      Scaffold.of(widget.c1).showSnackBar(SnackBar(
        content:
            Text('[${response.statusCode}] Error message: ${response.body}'),
      ));
    }
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
