import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'SizeConfig.dart';

const String AppURL="http://api.ipitrs.natrixsoftware.com/api/Project/";
const String BaseURL="http://api.ipitrs.natrixsoftware.com/api/";
final String msgConnection = "Server Error Occurred";
final String msgNoInternet = "No Internet Connection";
final String msgError = "Something went wrong!!";
const Color iconColor = Color(0xFFE8A561);
const Color iconGreenColor = Color(0xff58A480);

MaterialColor myOrange = const MaterialColor(0xFFFF8F00,
    const {
      50 : const Color(0xFFFF6F00),
      100 : const Color(0xFFFF6F00),
      200 : const Color(0xFFFF6F00),
      300 : const Color(0xFFFF6F00),
      400 : const Color(0xFFFF6F00),
      500 : const Color(0xFFFF6F00),
      600 : const Color(0xFFFF6F00),
      700 : const Color(0xFFFF6F00),
      800 : const Color(0xFFFF6F00),
      900 : const Color(0xFFFF6F00)});

const iPrimaryColor = Color(0xFFFF7643);
const iPrimaryLightColor = Color(0xFFFFECDF);
const iPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const iSecondaryColor = Color(0xFF979797);
const iTextColor = Color(0xFF757575);

const iAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
Future<bool> IsConnected() async {

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }else{
      print('else of connected');
    }
  } on SocketException catch (ex) {
    print('not connected');
    return false;
  }
}

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String iEmailNullError = "Please Enter your email";
const String iInvalidEmailError = "Please Enter Valid Email";
const String iPassNullError = "Please Enter your password";
const String iShortPassError = "Password is too short";
const String iMatchPassError = "Passwords don't match";
const String iNamelNullError = "Please Enter your name";
const String iPhoneNumberNullError = "Please Enter your phone number";
const String iAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: Colors.orange),
  );
}

Widget getLoader(){
  return Image.asset(
    "assets/images/BigSpinner.gif",
    height: 125.0,
    width: 125.0,
  );
}

Widget getImageLoader(){
  return
   // Image(image: assetImageNatrix);
    Image.asset(
    "assets/images/Spinner.gif",
    height: 100.0,
    width: 100.0,
  );
}
