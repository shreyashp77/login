import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  DescriptionPage(
      {@required this.title, @required this.description, @required this.topic});

  final title;
  final description;
  final topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(description),
            RaisedButton(
              child: Text('Back'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
