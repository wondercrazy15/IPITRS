import 'package:flutter/material.dart';
import 'package:project/Views/HomeView.dart';
import 'package:project/Views/MainView.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Future<void> main() async
//{
//  WidgetsFlutterBinding.ensureInitialized();
//  runApp(MaterialApp(home: MainView()));
//}
Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLogin = prefs.getBool("IsLogin");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: isLogin == null ?
      MainView()
          : HomeView()));
}