import 'package:flutter/material.dart';
import 'package:login/secondpage.dart';
import 'secondpage.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {@required this.title, @required this.description, @required this.topic});

  final title;
  final description;
  final topic;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(title),
              subtitle: Text(description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                        title: title, description: description, topic: topic),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
