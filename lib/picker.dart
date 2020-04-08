import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//Image Plugin
import 'package:image_picker/image_picker.dart';
import 'package:login/demo.dart';
import 'package:path/path.dart' as Path;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File sampleImage;
  String name;
  TextEditingController cont;
  String uurl = "";

  Future<String> getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('/events/${Path.basename(sampleImage.path)}');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);

    await task.onComplete;

    print('File Uploaded');
    final StorageTaskSnapshot downloadUrl = (await task.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    //print('URL Is $url');

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Upload'),
        centerTitle: true,
      ),
      body: new Center(
        child: sampleImage == null
            ? Text('Select an image')
            : RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Demo(
                        url: uurl,
                      ),
                    ),
                  );
                },
                child: Text('GO'),
              ),
        // : Image.network(uploadedFileURL), //enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          getImage().then((v) => setState(() {
                uurl = v;
              }));
        },
        tooltip: 'Add Image',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Widget enableUpload() {
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         Image.file(sampleImage, height: 300.0, width: 300.0),
  //       ],
  //     ),
  //   );
  // }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300.0, width: 300.0),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Title',
            ),
            controller: cont,
          ),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              setState(() {
                name = cont.text;
              });

              final StorageReference firebaseStorageRef =
                  FirebaseStorage.instance.ref().child('/events/$name.jpg');
              final StorageUploadTask task =
                  firebaseStorageRef.putFile(sampleImage);
            },
          )
        ],
      ),
    );
  }
}
