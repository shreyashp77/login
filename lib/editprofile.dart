import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'crud.dart';

class Item {
  const Item(this.gender, this.icon);
  final String gender;
  final FaIcon icon;
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Item selectedGender;
  List<Item> genders = <Item>[
    const Item(
      'Male',
      FaIcon(
        FontAwesomeIcons.mars,
        color: Colors.blue,
      ),
    ),
    const Item(
        'Female',
        FaIcon(
          FontAwesomeIcons.venus,
          color: Colors.pink,
        )),
    const Item(
        'Other',
        FaIcon(
          FontAwesomeIcons.transgender,
          color: Colors.purple,
        )),
    const Item(
        'Prefer not to specify',
        FaIcon(
          FontAwesomeIcons.genderless,
          color: Colors.grey,
        )),
  ];

  FirebaseUser user;

  String dob = "";
  String uname;
  String uaddress;
  String gender = "";
  double progress;
  String progressPercent;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static SharedPreferences _sharedPreferences;

  Future<FirebaseUser> getUser() async {
    FirebaseUser usr = await FirebaseAuth.instance.currentUser();
    return usr;
  }

  loadProgressValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      progress = (prefs.getDouble('progress')) ?? 0.25;
      progressPercent = (prefs.getString('percent')) ?? '25%';
    });
  }

  saveProgressValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble('progress', progress);
      if (progress == 0.25) {
        progressPercent = "25%";
      } else if (progress == 0.5) {
        progressPercent = "50%";
      } else if (progress == 0.75) {
        progressPercent = "75%";
      } else if (progress == 1.0) {
        progressPercent = "100%";
      }
      prefs.setString('percent', progressPercent);
    });
  }

  dynamic data;

  Future<dynamic> getUserProgress() async {
    final DocumentReference document =
        Firestore.instance.collection("users").document(user.uid);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data = snapshot.data;
      });
    });
  }

  checkAndUpdate() {
    uname = name.text;
    uaddress = address.text;

    if (dob.isNotEmpty) {
      Crud().updateDOB(user, dob);
      setState(() {
        if (progress < 1.0) progress += 0.25;
        saveProgressValue();
        if (progress == 0.25) {
          progressPercent = "25%";
        } else if (progress == 0.5) {
          progressPercent = "50%";
        } else if (progress == 0.75) {
          progressPercent = "75%";
        } else if (progress == 1.0) {
          progressPercent = "100%";
        }
      });
    }
    if (uname.isNotEmpty) {
      Crud().updateName(user, uname);
    }
    if (uaddress.isNotEmpty) {
      Crud().updateAddress(user, uaddress);
      setState(() {
        if (progress < 1.0) progress += 0.25;
        saveProgressValue();
        if (progress == 0.25) {
          progressPercent = "25%";
        } else if (progress == 0.5) {
          progressPercent = "50%";
        } else if (progress == 0.75) {
          progressPercent = "75%";
        } else if (progress == 1.0) {
          progressPercent = "100%";
        }
      });
    }
    if (gender.isNotEmpty) {
      Crud().updateGender(user, gender);
      setState(() {
        if (progress < 1.0) progress += 0.25;
        saveProgressValue();
        if (progress == 0.25) {
          progressPercent = "25%";
        } else if (progress == 0.5) {
          progressPercent = "50%";
        } else if (progress == 0.75) {
          progressPercent = "75%";
        } else if (progress == 1.0) {
          progressPercent = "100%";
        }
      });
    }
    Crud().updateProgress(user, progress.toString());
  }

  List<bool> _list = [false, false, false, false];

  @override
  void initState() {
    getUser().then((FirebaseUser usr) {
      setState(() {
        user = usr;
      });
    });
    //getUserProgress();
    loadProgressValue();

    // progress = double.parse(data['progress']);
    if (progress == 0.25) {
      progressPercent = "25%";
    } else if (progress == 0.5) {
      progressPercent = "50%";
    } else if (progress == 0.75) {
      progressPercent = "75%";
    } else if (progress == 1.0) {
      progressPercent = "100%";
    }
    super.initState();
  }

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //progress = double.parse(data['progress']);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
              ),
              child: GFProgressBar(
                percentage: progress < 1.0 ? progress : 1.0,
                lineHeight: 20,
                animation: true,

                //padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                alignment: MainAxisAlignment.spaceBetween,
                child: Text(
                  progressPercent,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                backgroundColor: Colors.black26,
                progressBarColor: Colors.blueAccent,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 70,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: Icon(Icons.person),
                  hintText: user.displayName,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 32.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextFormField(
                controller: address,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: Icon(Icons.my_location),
                  hintText: 'Address',
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 32.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            //   DropdownButton<Item>(
            //     hint: Text("Gender"),
            //     value: selectedGender,
            //     onChanged: (Item genderValue) {
            //       setState(() {
            //         selectedGender = genderValue;
            //       });
            //     },
            //     items: genders.map((Item gender) {
            //       return DropdownMenuItem<Item>(
            //         value: gender,
            //         child: Row(
            //           children: <Widget>[
            //             gender.icon,
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Text(
            //               gender.gender,
            //               style: TextStyle(color: Colors.black),
            //             ),
            //           ],
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   height: MediaQuery.of(context).size.width * 0.12,
            //   child: GFButton(
            //     onPressed: () {},
            //     text: "Date of Birth",
            //     icon: FaIcon(FontAwesomeIcons.birthdayCake),
            //     color: Colors.grey,
            //     type: GFButtonType.outline,
            //     shape: GFButtonShape.pills,
            //     size: GFSize.LARGE,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextFormField(
                //controller: address,
                onTap: () {
                  // Below line stops keyboard from appearing
                  FocusScope.of(context).requestFocus(new FocusNode());

                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.blue, //Head background
                          accentColor: Colors.blue, //selection color
                          colorScheme: ColorScheme.light(primary: Colors.blue),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                          //dialogBackgroundColor: Colors.white,//Background color
                        ),
                        child: child,
                      );
                    },
                  ).then((date) {
                    setState(() {
                      dob = DateFormat('dd/MM/yyyy').format(date);
                    });
                    //print('date................' + sdate);
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: Icon(Icons.cake),
                  hintText: dob == "" ? 'DOB: dd/mm/yyyy' : dob,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 32.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text("Gender"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.120,
                  height: MediaQuery.of(context).size.height * 0.062,
                  child: GFIconButton(
                    onPressed: () {
                      setState(() {
                        _list[0] = !_list[0];
                        if (_list[1] != false) _list[1] = false;
                        if (_list[2] != false) _list[2] = false;
                        if (_list[3] != false) _list[3] = false;
                        if (_list[0] == true) gender = "Male";
                      });
                    },
                    icon: FaIcon(FontAwesomeIcons.mars),
                    type: _list[0]
                        ? GFButtonType.outline
                        : GFButtonType.transparent,
                    iconSize: 35,
                    size: GFSize.LARGE,
                    tooltip: 'male',
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.125,
                  height: MediaQuery.of(context).size.height * 0.062,
                  child: GFIconButton(
                    onPressed: () {
                      setState(() {
                        _list[1] = !_list[1];
                        if (_list[0] != false) _list[0] = false;
                        if (_list[2] != false) _list[2] = false;
                        if (_list[3] != false) _list[3] = false;
                        if (_list[1] == true) gender = "Female";
                      });
                    },
                    color: Colors.pink,
                    icon: FaIcon(FontAwesomeIcons.venus),
                    type: _list[1]
                        ? GFButtonType.outline
                        : GFButtonType.transparent,
                    iconSize: 34,
                    size: GFSize.LARGE,
                    tooltip: 'female',
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.125,
                  height: MediaQuery.of(context).size.height * 0.062,
                  child: GFIconButton(
                    onPressed: () {
                      setState(() {
                        _list[2] = !_list[2];
                        if (_list[0] != false) _list[0] = false;
                        if (_list[1] != false) _list[1] = false;
                        if (_list[3] != false) _list[3] = false;
                        if (_list[2] == true) gender = "Other";
                      });
                    },
                    color: Colors.purple,
                    icon: FaIcon(FontAwesomeIcons.venusMars),
                    type: _list[2]
                        ? GFButtonType.outline
                        : GFButtonType.transparent,
                    iconSize: 33,
                    size: GFSize.LARGE,
                    tooltip: 'other',
                  ),
                ),
              ],
            ),
            Container(
              child: GFButton(
                onPressed: () {
                  setState(() {
                    _list[3] = !_list[3];
                    if (_list[0] != false) _list[0] = false;
                    if (_list[1] != false) _list[1] = false;
                    if (_list[2] != false) _list[2] = false;
                    if (_list[3] == true) gender = "NaN";
                  });
                },
                text: 'Prefer not to tell',
                highlightColor: Theme.of(context).scaffoldBackgroundColor,
                splashColor: Theme.of(context).scaffoldBackgroundColor,
                focusColor: Theme.of(context).scaffoldBackgroundColor,
                hoverColor: Theme.of(context).scaffoldBackgroundColor,
                type:
                    _list[3] ? GFButtonType.outline : GFButtonType.transparent,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: GFButton(
                onPressed: () {
                  uname = name.text;
                  uaddress = address.text;
                  checkAndUpdate();
                  // if (dob.isNotEmpty) {
                  //   Crud().updateDOB(user, dob);
                  //   progress += 0.25;
                  // }
                  // if (uname.isNotEmpty) {
                  //   Crud().updateName(user, uname);
                  // }
                  // if (uaddress.isNotEmpty) {
                  //   Crud().updateAddress(user, uaddress);
                  //   progress += 0.25;
                  // }
                  // if (gender.isNotEmpty) {
                  //   Crud().updateGender(user, gender);
                  //   progress += 0.25;
                  // }
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text('Profile Updated!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  //Navigator.pop(context);
                },
                text: "Update Profile",
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
