import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/Models/ProjectInfo.dart';

import 'FullScreenImage.dart';
import 'constants.dart';

class ImageList extends StatefulWidget {
  String name;
  List<ProjectImageList> imgList;
  ImageList(this.name,this.imgList);

  @override
  State<StatefulWidget> createState() {
    return _ImageList(this.name,this.imgList);
  }

}

class _ImageList extends State<ImageList> {
  //
  CarouselSlider carouselSlider;
  int _current = 0;

//  List imgList = [
//    "assets/images/Project1.jpg",
//    "assets/images/Project2.jpg",
////    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
////    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
////    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
////    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
////    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
//  ];
  String name;
  List<ProjectImageList> imgList;
  _ImageList(this.name,this.imgList);

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          carouselSlider = CarouselSlider(
            options: CarouselOptions(

              initialPage: 0,
              viewportFraction: 1,

              enlargeCenterPage: true,
              autoPlay: (imgList.length>1)?true:false,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index,resun) {
                setState(() {
                  _current = index;
                });
              },

            ),

            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Color(0xffFFB971),Color(0xff008000)
                            ])
                    ),
                    child:
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                              return FullScreenImage(
                                imageUrl:imgUrl.filePath,
                                tag: imgUrl.filePath,
                              );
                            }));
                      },
                      child: Hero(
                        child:
                        CachedNetworkImage(
                          imageUrl: imgUrl.filePath,fit: BoxFit.cover,
                          placeholder: (context, url) => getImageLoader(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          width: MediaQuery.of(context).size.width - 30,
                          height: MediaQuery.of(context).size.height /4.5,

                        ),
                        tag: imgUrl.filePath,
                      ),
                    ),
                    // CachedNetworkImage(
                    //   imageUrl: imgUrl.filePath,fit: BoxFit.cover,
                    //   placeholder: (context, url) => getImageLoader(),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    //   width: MediaQuery.of(context).size.width - 30,
                    //   height: MediaQuery.of(context).size.height /4.5,
                    //
                    // ),
//                    Image.network(
//                      imgUrl.filePath,
//                      fit: BoxFit.fill,
//                    ),
                  );
                },
              );
            }).toList(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imgList, (index, url) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.orange : Colors.green,
                ),
              );
            }),
          ),


        ],
      ),
    );
  }


}