import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/UserInfo.dart';
import 'package:project/ViewModels/MyProfileViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import 'DefaultButton.dart';
import 'SizeConfig.dart';
import 'constants.dart';

class MyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _myProfile();
  }
}

class _myProfile extends State<MyProfile> {
  File _image;
  String _img64 = "";
  final picker = ImagePicker();

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final bytes = _image.readAsBytesSync();
        _img64 = "";
        _img64 = base64Encode(bytes);
        print(_img64);
        setState(() {
          isSelectedProfile = true;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        var bytes = _image.readAsBytesSync();
        _img64 = "";
        _img64 = base64Encode(bytes);
        print(_img64);
        setState(() {
          isSelectedProfile = true;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  String phoneNumber;
  String adharnumber = "";
  String userName;
  String Email;
  String UserId;
  bool isFromLogin;
  String Bdate;
  String date;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  bool isSelectedDate = false;
  bool isSelectedProfile = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime picked = await showRoundedDatePicker(
        height: MediaQuery.of(context).size.height / 2.5,
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime.now(),
        borderRadius: 16,
        theme: ThemeData(primarySwatch: myOrange),
        styleDatePicker: MaterialRoundedDatePickerStyle(
          textStyleDayButton: TextStyle(fontSize: 36, color: Colors.white),
          textStyleYearButton: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          textStyleMonthYearHeader: TextStyle(
              fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold),
          paddingMonthHeader: EdgeInsets.all(20),
          paddingActionBar: EdgeInsets.all(16),
          sizeArrow: 50,
          colorArrowNext: Colors.orange,
          colorArrowPrevious: Colors.orange,
          textStyleDayOnCalendarSelected:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ));
    if (picked != null)
      setState(() {
        isSelectedDate = true;
        selectedDate = picked;
        if (isSelectedDate) {
          txtDOB.text = PassFormatter.format(selectedDate);
          //Bdate=PassFormatter.format(selectedDate);
        }
      });

//    final DateTime picked = await showRoundedDatePicker(
//        context: context,
//        initialDate: selectedDate,
//        firstDate: DateTime(2015, 8),
//        lastDate: DateTime(2101));
//    if (picked != null && picked != selectedDate)
//      setState(() {
//        selectedDate = picked;
//      });
  }

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat PassFormatter = DateFormat('yyyy-MM-dd');

  String getDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    final String formatted = PassFormatter.format(dateTime);
    return formatted;
  }

  TextEditingController txtDOB = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return ViewModelBuilder<MyProfileViewModel>.reactive(
        viewModelBuilder: () => MyProfileViewModel(),
        onModelReady: (model) async => await model.initModel(context),
        builder: (context, model, child) {
          txtDOB.text = (isSelectedDate)
              ? PassFormatter.format(selectedDate)
              : (model.userInfo.data) != null
                  ? (model.userInfo.data.birthDate != "")
                      ? getDate(model.userInfo.data.birthDate)
                      : ""
                  : "";
          return ModalProgressHUD(
              opacity: 0.5,
              inAsyncCall: model.isBusy,
              progressIndicator: getLoader(),
              color: Colors.white,
              child: Scaffold(
                  appBar: AppBar(
                      centerTitle: true,
                      title: Text("My Profile", style: TextStyle(fontSize: 18)),
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                              Color(0xffff8000),
                              Color(0xff008000)
                            ])),
                      )),
                  body: SingleChildScrollView(
                    child: (model.userInfo.data != null)
                        ? Column(
                            children: <Widget>[
                              SizedBox(
                                height: 32,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child:
                                      ClipOval(child: getProfileImage(model)),
                                ),
//                                  Container(
//                                    margin: EdgeInsets.all(2),
//                                    width: 100,
//                                    height: 100,
//                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
//                                      image: DecorationImage(
//                                          image: getProfileImage(model),
//                                          fit: BoxFit.fill),
//                                    ),
//                                  ),

//                                  CircleAvatar(
//                                      radius: 55,
//                                      backgroundColor: Colors.orange,
//                                      child:
//                                      getProfileImage(model))
                              ),
                              Form(
                                key: _formKey,
                                child: Center(
                                    child: ListView(
                                        padding: EdgeInsets.all(20),
                                        physics: new ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 15), // 4%

                                          Theme(
                                            child: TextFormField(
                                              initialValue:
                                                  model.userInfo.data.name,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onSaved: (newValue) =>
                                                  userName = newValue,
                                              onEditingComplete: () =>
                                                  node.nextFocus(),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 15),
                                                suffixIcon: Icon(Icons
                                                    .account_circle_outlined),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                labelText: "Username",
                                                hintText: "Enter Username",
                                              ),
                                              cursorColor: Colors.orange,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return "Please enter Username";
                                                }
                                              },
                                              keyboardType: TextInputType.name,
                                            ),
                                            data: Theme.of(context).copyWith(
                                              primaryColor: Colors.orange,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Theme(
                                            child: TextFormField(
                                              enabled: false,
                                              initialValue:
                                                  model.userInfo.data.email,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onEditingComplete: () =>
                                                  node.nextFocus(),
                                              onSaved: (newValue) =>
                                                  Email = newValue,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 15),
                                                suffixIcon:
                                                    Icon(Icons.email_outlined),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                labelText: "Email",
                                                hintText: "Enter Email",
                                              ),
                                              cursorColor: Colors.orange,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return "Please enter Email";
                                                } else if (!emailValidatorRegExp
                                                    .hasMatch(value)) {
                                                  return "Please enter valid Email";
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                            data: Theme.of(context).copyWith(
                                              primaryColor: Colors.orange,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Theme(
                                            child: TextFormField(
                                              enabled: false,
                                              initialValue: model
                                                  .userInfo.data.mobileNumber,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onEditingComplete: () =>
                                                  node.unfocus(),
                                              onSaved: (newValue) =>
                                                  phoneNumber = newValue,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 15,
                                                          horizontal: 15),
                                                  suffixIcon:
                                                      Icon(Icons.phone_android),
//                                      focusedBorder: UnderlineInputBorder(
//                                        borderSide: BorderSide(
//                                            color: Colors.orange),
//                                      ),
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      const Radius.circular(
                                                          10.0),
                                                    ),
                                                  ),
                                                  labelText: "Mobileno",
                                                  hintText: "Enter MobileNo",
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always),
                                              cursorColor: Colors.orange,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return "Please enter mobileno";
                                                } else if (value.length != 10) {
                                                  return "Please enter valid mobile no";
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            data: Theme.of(context).copyWith(
                                              primaryColor: Colors.orange,
                                            ),
                                          ),
                                          SizedBox(height: 15),

                                          Stack(
                                            alignment: Alignment.centerRight,
                                            children: <Widget>[
                                              Theme(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _selectDate(context);
                                                  },
                                                  child: TextFormField(
                                                    enabled: false,
                                                    controller: txtDOB,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    onEditingComplete: () =>
                                                        node.unfocus(),
                                                    onSaved: (newValue) =>
                                                        date = newValue,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        15,
                                                                    horizontal:
                                                                        15),
                                                        border:
                                                            new OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            const Radius
                                                                .circular(10.0),
                                                          ),
                                                        ),
                                                        labelText: "Birthdate",
                                                        hintText:
                                                            "Enter Birthdate",
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always),
                                                    cursorColor: Colors.orange,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                  ),
                                                ),
                                                data:
                                                    Theme.of(context).copyWith(
                                                  primaryColor: Colors.orange,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.date_range,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  _selectDate(context);
                                                  // Your codes...
                                                },
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 15),

                                          Theme(
                                            child: TextFormField(
                                              initialValue:
                                                  model.userInfo.data.udid,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onEditingComplete: () =>
                                                  node.unfocus(),
                                              onSaved: (newValue) =>
                                                  adharnumber = newValue,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 15,
                                                          horizontal: 15),
                                                  suffixIcon: Icon(Icons
                                                      .account_balance_wallet),
//                                      focusedBorder: UnderlineInputBorder(
//                                        borderSide: BorderSide(
//                                            color: Colors.orange),
//                                      ),
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      const Radius.circular(
                                                          10.0),
                                                    ),
                                                  ),
                                                  labelText: "Adharno",
                                                  hintText:
                                                      "Enter adharcard number",
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always),
                                              cursorColor: Colors.orange,
//                                              validator: (String value) {
//                                                if (value.isEmpty) {
//                                                  return "Please enter adharcard number";
//                                                } else if (value.length != 10) {
//                                                  return "Please enter valid adharcard number";
//                                                }
//                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            data: Theme.of(context).copyWith(
                                              primaryColor: Colors.orange,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          DefaultButton(
                                            text: "Update",
                                            press: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                print(userName +
                                                    "  " +
                                                    Email +
                                                    "  " +
                                                    _img64 +
                                                    phoneNumber);
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                if (prefs.getString("UserId") !=
                                                    null)
                                                  UserId =
                                                      prefs.getString("UserId");
                                                final respo = await model
                                                    .UpdateUser(UpdateUserInfo(
                                                        name: userName,
                                                        email: Email,
                                                        mobileNumber:
                                                            phoneNumber,
                                                        udid: adharnumber,
                                                        birthDate:
                                                            (txtDOB.text == "")
                                                                ? null
                                                                : txtDOB.text,
                                                        profilePicture: _img64,
                                                        userId: UserId));
                                                if (respo.status) {
                                                  prefs.setString("Profile",
                                                      respo.data.profileImage);
                                                  Navigator.pop(context);
                                                  Toast.show(
                                                      respo.message, context,
                                                      duration:
                                                          Toast.LENGTH_LONG,
                                                      gravity: Toast.BOTTOM);
                                                } else {
                                                  Toast.show(
                                                      respo.message, context,
                                                      duration:
                                                          Toast.LENGTH_LONG,
                                                      gravity: Toast.BOTTOM);
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ])),
                              ),
                            ],
                          )
                        : Container(),
                  )));
        });
  }

  void back() {
    Navigator.pop(context, true);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: new Icon(Icons.photo_library, color: iconColor),
                    title: Text(
                      'Photo Library',
                      style: TextStyle(
                          foreground: Paint()..shader = linearOrangeGradient),
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: new Icon(Icons.photo_camera, color: iconColor),
                    title: Text(
                      'Camera',
                      style: TextStyle(
                          foreground: Paint()..shader = linearOrangeGradient),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;

  getProfileImage(MyProfileViewModel model) {
    if (isSelectedProfile) {
      return Image.file(
        _image,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    } else {
      if (model.userInfo.data.profileImage != null &&
          model.userInfo.data.profileImage != "") {
        return CachedNetworkImage(
          imageUrl: model.userInfo.data.profileImage,
          fit: BoxFit.cover,
          placeholder: (context, url) => getImageLoader(),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/user.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          width: 100,
          height: 100,
        );
      } else {
        return Image.asset(
          'assets/images/user.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        );
      }
    }
  }
}
