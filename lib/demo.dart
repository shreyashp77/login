import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  bool p = false;
  List uu;
  String sdate = 'Not set';

  Future<void> checkOn() async {
    var now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(now);
    DocumentReference documentRef =
        Firestore.instance.collection("daily").document(date);
    DocumentSnapshot doc = await documentRef.get();
    uu = doc.data['url'];
    setState(() {
      p = true;
    });
  }

  Future<void> differentDay(String givenDate) async {
    DocumentReference documentRef =
        Firestore.instance.collection("daily").document(givenDate);
    DocumentSnapshot doc = await documentRef.get();
    final ss =
        await Firestore.instance.collection("daily").document(givenDate).get();
    if (ss.exists) uu = doc.data['url'];
    setState(() {
      p = true;
    });
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
        centerTitle: true,
        title: Text('Daily Darshan'),
      ),
      body: p
          ? GridView.builder(
              //crossAxisCount: 4,
              itemCount: uu.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0),
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
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),

              //mainAxisSpacing: 0.0,
              //crossAxisSpacing: 0.0,
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.calendar_today),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime(2020, 04, 01),
            firstDate: DateTime(2020),
            lastDate: DateTime(2021),
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
}
