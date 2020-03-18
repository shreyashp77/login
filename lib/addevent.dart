import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Events'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Enter the details ',
                      style: TextStyle(fontSize: 22))),
              Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    //controller: titleController,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Title'),
                  )),
              Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    //controller: bodyController,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Body'),
                  )),
              RaisedButton(
                onPressed: () {
                  //webCall();
                  //sendNotification();
                },
                color: Colors.pink,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text('Submit'),
              ),
              // Visibility(
              //     visible: visible,
              //     child: Container(
              //         margin: EdgeInsets.only(bottom: 30),
              //         child: CircularProgressIndicator())),
            ],
          ),
        )));
  }
}
