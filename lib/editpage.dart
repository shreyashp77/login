import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  DescriptionPage(
      {@required this.title,
      @required this.description,
      @required this.topic,
      @required this.ndate,
      @required this.stime});

  final title;
  final description;
  final topic;
  final ndate;
  final stime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Description : ' + description),
            Text('Date : ' + ndate),
            Text('Time : ' + stime),
            // RaisedButton(
            //   child: Text('Back'),
            //   color: Theme.of(context).primaryColor,
            //   textColor: Colors.white,
            //   onPressed: () => Navigator.pop(context),
            // ),
          ],
        ),
      ),
    );
  }
}
