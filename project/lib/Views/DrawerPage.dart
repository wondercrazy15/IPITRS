import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:project/Views/MainView.dart';
import 'package:project/Views/MyComplainView.dart';
import 'package:project/Views/MyProfile.dart';
import 'package:project/Views/MyQueryView.dart';
import 'package:project/Views/MyRatingReviewView.dart';
import 'package:project/Views/MySuggestionView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'HelpView.dart';
import 'SizeConfig.dart';
import 'constants.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerPage();
  }
}

class _DrawerPage extends State<DrawerPage> {
  String Version = "";
  AssetImage assetImageNatrix;
  void initState() {
    // TODO: implement initState

    assetImageNatrix = AssetImage('assets/images/Natrix.png');

    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs != null) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        Version = packageInfo.version;
        email = await prefs.getString("email");
        name = await prefs.getString("name");
        Profile = await prefs.getString("Profile");
        setState(() {});
        print(email);
      }
    })();
    super.initState();
  }

  String Profile = "";
  String email = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    precacheImage(assetImageNatrix, context);
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: new ClampingScrollPhysics(),
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffFF9933), Color(0xff58A451)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: DrawerHeader(
//              decoration: BoxDecoration(
//                  image: DecorationImage(
//                      image: Profile!=null?NetworkImage(Profile):AssetImage("assets/images/Project1.jpg"),
//                      fit: BoxFit.cover
//                  )
//              ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        child: ClipOval(
                          child: (Profile != "" && Profile != null)
                              ?
                          CachedNetworkImage(
                                  imageUrl: Profile,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      getImageLoader(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/user.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  width: 100,
                                  height: 100,
                                )
                              : Image.asset(
                                  'assets/images/user.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        onTap: () async {
                          bool connected = await IsConnected();
                          if (!connected) {
                            Toast.show(msgNoInternet, context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                            return;
                          }
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfile()),
                          );
                        },
                      ),

//                Container(
//                  margin: EdgeInsets.all(2),
//                  width: 100,
//                  height: 100,
//                  decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    image: DecorationImage(
//                        image: (Profile!=""&&Profile!=null)?NetworkImage(Profile):AssetImage('assets/images/user.png'),
//                        fit: BoxFit.fill
//                    ),
//                  ),
//                ),

//                      CircleAvatar(
//                        radius: 50,
//                        backgroundColor: Colors.transparent,
//                        child: ClipOval(
//                          child:Image.asset("assets/images/Project1.jpg",width: 200,height: 200),),
//                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Text(email == null ? "" : email,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//          Container(
//            padding: EdgeInsets.only(bottom: 8.0),
//            color: Colors.blue,
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: Center(
//                    child: Text(email==null?"":email,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:15 )),
//                  ),
//
//                )
//              ],
//            ),
//          ),

              ListTile(
                leading: new Icon(
                  CupertinoIcons.pencil_outline,
                  color: iconColor,
                  size: 27,
                ),
                title: Text(
                  'My Reviews',
                  style: TextStyle(
                      fontSize: 17,
                      foreground: Paint()..shader = linearOrangeGradient),
                ),
                onTap: () async {
                  bool connected = await IsConnected();
                  if (!connected) {
                    Toast.show(msgNoInternet, context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyRatingReviewView()),
                  );
                },
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                leading: new Icon(
                  CupertinoIcons.question_circle,
                  color: iconColor,
                  size: 27,
                ),
                title: Text(
                  'My Query',
                  style: TextStyle(
                      fontSize: 17,
                      foreground: Paint()..shader = linearOrangeGradient),
                ),
                onTap: () async {
                  bool connected = await IsConnected();
                  if (!connected) {
                    Toast.show(msgNoInternet, context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyQueryView()),
                  );
                },
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                leading: new Icon(
                  CupertinoIcons.person_crop_circle_badge_exclam,
                  color: iconColor,
                  size: 27,
                ),
                title: Text(
                  'My Complains',
                  style: TextStyle(
                      fontSize: 17,
                      foreground: Paint()..shader = linearOrangeGradient),
                ),
                onTap: () async {
                  bool connected = await IsConnected();
                  if (!connected) {
                    Toast.show(msgNoInternet, context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyComplainView()),
                  );
                },
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),

              ListTile(
                leading: new Icon(
                  CupertinoIcons.pencil_outline,
                  color: iconColor,
                  size: 27,
                ),
                title: Text(
                  'My Suggestions',
                  style: TextStyle(
                      fontSize: 17,
                      foreground: Paint()..shader = linearOrangeGradient),
                ),
                onTap: () async {
                  bool connected = await IsConnected();
                  if (!connected) {
                    Toast.show(msgNoInternet, context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySuggestionView()),
                  );
                },
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),

//          ListTile(
//            leading: new Icon(
//              CupertinoIcons.person_crop_circle,
//              color: iconColor,
//              size: 27,
//            ),
//            title: Text(
//              'My Profile',
//              style: TextStyle(
//                  fontSize: 17,
//                  foreground: Paint()..shader = linearOrangeGradient),
//            ),
//            onTap: () async {
//              bool connected = await IsConnected();
//              if (!connected) {
//                Toast.show(msgNoInternet, context,
//                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//                return;
//              }
//              Navigator.pop(context);
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => MyProfile()),
//              );
//            },
//          ),
//          Container(
//            height: 1,
//            color: Colors.grey,
//          ),

//              ListTile(
//                leading: new Icon(
//                  CupertinoIcons.question_circle,
//                  color: iconColor,
//                  size: 27,
//                ),
//                title: Text(
//                  'Help',
//                  style: TextStyle(
//                      fontSize: 17,
//                      foreground: Paint()..shader = linearOrangeGradient),
//                ),
//                onTap: () async {
//                  bool connected = await IsConnected();
//                  if (!connected) {
//                    Toast.show(msgNoInternet, context,
//                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//                    return;
//                  }
//                  Navigator.pop(context);
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => HelpView()),
//                  );
//                },
//              ),
//              Container(
//                height: 1,
//                color: Colors.grey,
//              ),
              ListTile(
                leading: new Icon(
                  Icons.exit_to_app_rounded,
                  color: iconColor,
                  size: 27,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 17,
                      foreground: Paint()..shader = linearOrangeGradient),
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("IsLogin");
                  prefs.remove("email");
                  prefs.remove("UserId");
                  prefs.remove("Profile");
                  prefs.remove("MobileNo");
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MainView(),
                    ),
                    (Route route) => false,
                  );
                },
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        SafeArea(bottom: true, child:
        Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFF9933), Color(0xff58A451)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(3),
                child: Image.asset('assets/images/Natrix.png'),),
//                Image.asset(
//                  assetImageNatrix,
//                  fit: BoxFit.fill,
//                ),
                Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Text(Version,style: TextStyle(color: Colors.white),),
                )
              ],
            ))),
      ],
    ));
  }
}
