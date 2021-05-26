import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Color bgColor = Color(0xFFF3F3F3);
Color textColor = Color(0xFF83838A);

List<String> imagePath = [
  "assets/images/hand.png",
  "assets/images/intro2.png",
  "assets/images/intro3.png",
];
List<String> title = ["Welcome", "Browse", "Ready"];
List<String> description = [
  "Discover new project with IPITRS and scan project",
  "We connect you to your area working project and show you all the the information in one place.",
  "Find the perfect information of project for you."
];

class HelpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _helpViews();
  }
}

class _helpViews extends State<HelpView> {
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xffff8000), Color(0xff008000)])),
            //padding: EdgeInsets.only(top: 30),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            left: 24,
                            top: 14,
                            child: Text(
                              "IPITRS",
                              style: TextStyle(
                                  fontFamily: "AvenirBold",
                                  fontSize: 16,
                                  color: Colors.white),
                            )),
                        Positioned(
                            right: 24,
                            top: 14,
                            child: Text(
                              _current == 2 ? "DONE" : "SKIP",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  fontFamily: "SultanNahia"),
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          onPageChanged: (index, resun) {
                            setState(() {
                              _current = index;
                            });
                          },
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          initialPage: 0,
                          reverse: false,
                          viewportFraction: 1.0,
                          aspectRatio: MediaQuery.of(context).size.aspectRatio,
                          height: MediaQuery.of(context).size.height ,
                        ),
                        items: [0, 1, 2].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: <Widget>[
                                            Container(
                                              height: MediaQuery.of(context).size.height-300,
                                              child: Image.asset(
                                                imagePath[i],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Center(
                                                      child: new Text(
                                                        title[i],
                                                        style: TextStyle(
                                                            fontFamily: "Caslon", fontSize: 30, color: Colors.white),
                                                      )
                                                  ),
                                                  Padding(padding: EdgeInsets.all(5),
                                                  child: Center(
                                                    child: new Text(
                                                      description[i],
                                                      style: TextStyle(
                                                          fontFamily: "Caslon", fontSize: 16, color: Colors.white),
                                                    ),
                                                  ),
                                                  )

                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )

                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(

                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: Stack(
                      children: <Widget>[

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: map<Widget>(imagePath, (index, url) {
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
                        ),

                        Positioned(
                            right: 0,
                            top: _current != 2 ? 20 : 0,
                            child: _current != 2
                                ? Icon(Icons.arrow_forward,color: Colors.white,)
                                : LetsGo()
                        )
                      ],
                    ),
                  )
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: map<Widget>(imagePath, (index, url) {
//                    return
//
//
////                      Container(
////                      width: 10.0,
////                      height: 10.0,
////                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
////                      decoration: BoxDecoration(
////                        shape: BoxShape.circle,
////                        color: _current == index ? Colors.orange : Colors.green,
////                      ),
////                    );
//                  }),
//                ),
                ],
              ),
            )
        )
    );
  }
}


class Dots extends StatefulWidget {
  int index;

  Dots(this.index);

  @override
  _DotsState createState() => _DotsState();
}

class _DotsState extends State<Dots> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("deneme" + currentPage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, int index) {
        return Container(
            margin: EdgeInsets.only(right: index != 2 ? 4 : 0),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == widget.index ? Colors.orange : Colors.white,
                border: Border.all(color: Colors.orange)));
      },
    );
  }
}

class LetsGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height,
          width: 90,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 16,
                  left: 12,
                  child: Text(
                    "LET'S GO!",
                    style: TextStyle(color: Colors.black),
                  )
              ),
            ],
          ),
        ),

    );
  }
}
