import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  final url;

  const Demo({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(url),
    );
  }
}
