
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({Key key, this.imageUrl, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: GestureDetector(
        child: Center(
          child: Hero(

            tag: tag,
            child: PhotoView(
              backgroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xffff8000),
                        Color(0xff008000)
                      ])),
              imageProvider: NetworkImage(imageUrl),
              minScale: 0.6,
            )
            // CachedNetworkImage(
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.contain,
            //   imageUrl: imageUrl,
            // ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}