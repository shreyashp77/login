import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  DescriptionPage(
      {@required this.title,
      @required this.description,
      @required this.topic,
      @required this.ndate,
      @required this.stime,
      this.url,
      @required this.desc});

  final title;
  final description;
  final topic;
  final ndate;
  final stime;
  final url;
  final desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.orangeAccent,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    // backgroundColor: Colors.black,
                  ),
                ),
                background: Image.network(
                  url,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: Text(description),
        ),
      ),
    );
  }
}
