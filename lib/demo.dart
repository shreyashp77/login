import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import 'imagefull.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  static var now = DateTime.now();
  String date = DateFormat('dd-MM-yyyy').format(now);
  String p = '';
  List uu;
  String sdate = 'Not set';

  Future<void> checkOn() async {
    var now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(now);
    DocumentReference documentRef =
        Firestore.instance.collection("daily").document(date);
    DocumentSnapshot doc = await documentRef.get();
    final ss2 =
        await Firestore.instance.collection("daily").document(date).get();

    if (ss2.exists) {
      uu = doc.data['url'];
      setState(() {
        p = 'found';
      });
    } else {
      setState(() {
        p = 'dne';
      });
      print('.................NO>...............');
    }
    // uu = doc.data['url'];
    // setState(() {
    //   p = 'found';
    // });
  }

  Future<void> differentDay(String givenDate) async {
    DocumentReference documentRef =
        Firestore.instance.collection("daily").document(givenDate);
    DocumentSnapshot doc = await documentRef.get();
    final ss =
        await Firestore.instance.collection("daily").document(givenDate).get();
    if (ss.exists) {
      uu = doc.data['url'];
      setState(() {
        p = 'found';
      });
    } else {
      setState(() {
        p = 'dne';
      });
      print('.................NO>...............');
    }
  }

  @override
  void initState() {
    super.initState();

    checkOn().whenComplete(() {
      setState(() {});
      print('..................success.................');
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text(
          'Daily Darshan',
          style: TextStyle(color: Colors.black),
        ),

        backgroundColor: Color(0xfffdfcfa),

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
      body: showThis(p),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfffdfcfa),
        child: FaIcon(
          FontAwesomeIcons.calendarAlt,
          color: Colors.black,
        ),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2021),
            // builder: (BuildContext context, Widget child) {
            //   return Theme(
            //     data: ThemeData.light().copyWith(
            //       primaryColor: Colors.orangeAccent, //Head background
            //       accentColor: Colors.orangeAccent, //selection color
            //       colorScheme: ColorScheme.light(primary: Colors.orangeAccent),
            //       buttonTheme:
            //           ButtonThemeData(textTheme: ButtonTextTheme.primary),
            //       //dialogBackgroundColor: Colors.white,//Background color
            //     ),
            //     child: child,
            //   );
            // },
          ).then((date) {
            setState(() {
              sdate = DateFormat('dd-MM-yyyy').format(date);
            });
            print('date................' + sdate);
            differentDay(sdate).whenComplete(() {
              setState(() {});
              print('..................success.................');
            }).catchError((error, stackTrace) {
              print("outer: $error");
            });
          });
        },
      ),
    );
  }

  Widget showThis(String p) {
    if (p == 'found') {
      return GridView.builder(
        //crossAxisCount: 4,
        itemCount: uu.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 0.0, mainAxisSpacing: 0.0),
        itemBuilder: (BuildContext context, int index) => Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageFull(
                        url: uu[index],
                      ),
                    ),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: uu[index],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),

        //mainAxisSpacing: 0.0,
        //crossAxisSpacing: 0.0,
      );
    } else if (p == 'dne')
      return Center(
        child: Text(
          'No Images Found!',
          style: TextStyle(fontSize: 20),
        ),
      );
    else
      return Center(
          child: CircularProgressIndicator(
              //valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
              ));
  }
}
