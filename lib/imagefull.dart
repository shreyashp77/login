import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFull extends StatelessWidget {
  final String url;

  const ImageFull({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => CircularProgressIndicator(),
        fit: BoxFit.fitWidth,
      ),
      // decoration: BoxDecoration(
      //   image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      // ),
    );
  }
}
