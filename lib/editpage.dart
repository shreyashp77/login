import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DescriptionPage extends StatelessWidget {
  DescriptionPage(
      {@required this.title,
      @required this.description,
      //@required this.topic,
      @required this.ndate,
      @required this.stime,
      this.url,
      @required this.desc});

  final title;
  final description;
  //final topic;
  final ndate;
  final stime;
  final url;
  final desc;

  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          var tag1;
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.orangeAccent,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      // backgroundColor: Colors.orangeAccent,
                    ),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Text(
                description,
                style: TextStyle(fontSize: 28),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ndate,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                  ),
                  Text(
                    stime,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(desc),
            ),
          ],
        ),
      ),
    );
  }
}
