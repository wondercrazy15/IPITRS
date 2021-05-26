import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Complain.dart';
import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Models/Query.dart';
import 'package:project/ViewModels/ComplainViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import 'DefaultButton.dart';
import 'constants.dart';


class ComplainView extends StatefulWidget {
  Data complainProject;
  bool iSComplain;
  ComplainView(this.complainProject,this.iSComplain);

  @override
  State<StatefulWidget> createState() {
    return _complainView(this.complainProject,this.iSComplain);
  }

}

class _complainView extends State<ComplainView> {
  List<String> attachments = [];
  bool isHTML = false;
  String email="";
  String id="";
  void initState() {
    // TODO: implement initState
    super.initState();

    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs!=null) {
        email = await prefs.getString("email");
        id = await prefs.getString("UserId");
        setState(() {
        });
      }
    })();

  }
  final _recipientController = TextEditingController(
  );

  final _subjectController = TextEditingController();

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Data complainProject;
  bool iSComplain;
  _complainView(this.complainProject,this.iSComplain);

//  Future<void> send() async {
//    final Email email = Email(
//      body: _bodyController.text,
//      subject: _subjectController.text,
//      recipients: [_recipientController.text],
//      attachmentPaths: attachments,
//      isHTML: isHTML,
//    );
//
//    String platformResponse;
//
//    try {
//      await FlutterEmailSender.send(email);
//      Navigator.pop(context);
//    } catch (error) {
//      platformResponse = "Gmail account not found";
//    }
//
//    if (!mounted) return;
//
//    _scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(platformResponse),
//    ));
//  }
  File _image;
  _imgFromCamera() async {

    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        attachments.add(pickedFile.path);
      });
    }
       setState(() {
      var bytes = pickedFile.readAsBytes();
    });
  }

  _imgFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        attachments.add(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _subjectController.text=(this.iSComplain)?"Complain about project "+this.complainProject.name:"Query about project "+this.complainProject.name;
    _bodyController.text=(this.iSComplain)?"My Complain about this project is "+"\n":"My Query about this project is"+"\n";
    _recipientController.text=this.complainProject.contractorList.first.email;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));
    return ViewModelBuilder<ComplainViewModel>.reactive(
        viewModelBuilder: () => ComplainViewModel(),
        onModelReady: (model) async => await model.initModel(context),
        builder: (context, model, child) {
          return KeyboardDismisser(
              gestures: [
              GestureType.onTap,
              GestureType.onPanUpdateDownDirection,
              ],
              child: ModalProgressHUD(
              inAsyncCall: model.isBusy,
              progressIndicator: getLoader(),
          color: Colors.white,
          child:
                Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text((this.iSComplain)?"Complain":"Query",style: TextStyle(color: Colors.white,fontSize: 18),),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xffff8000),Color(0xff008000)
                    ])
            ),),
//          actions: <Widget>[
//            IconButton(
//              onPressed: (){
//
//              },
//              icon: Icon(Icons.send,color: Colors.white,),
//            )
//          ],
        ),
        body: Theme(
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child:
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height-100,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          cursorColor: Colors.orange,
                          controller: _recipientController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Recipient',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          cursorColor: Colors.orange,
                          controller: _subjectController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Subject',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            cursorColor: Colors.orange,
                            controller: _bodyController,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                                labelText: 'Body', border: OutlineInputBorder()),
                          ),
                        ),
                      ),
//              CheckboxListTile(
//                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
//                title: Text('HTML'),
//                onChanged: (bool value) {
//                  setState(() {
//                    isHTML = value;
//                  });
//                },
//                value: isHTML,
//              ),
                      SafeArea(child: Padding(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          children: <Widget>[
                            for (var i = 0; i < attachments.length; i++) Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    attachments[i],
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () => { _removeAttachment(i) },
                                )
                              ],
                            ),
                            Row(

                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width -36,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: RaisedButton(
                                        onPressed: ()async{
                                          //send();
//                                          body: _bodyController.text,
//                                          subject: _subjectController.text,
//                                          recipients: [_recipientController.text],
                                        if(iSComplain){
                                          final respo = await model.AddProjectComplain(Complain(
                                            senderEmail: email,
                                            receiverEmail:"heavendev0005@gmail.com" ,//[_recipientController.text].first,
                                            description: _bodyController.text,
                                            query: _subjectController.text,
                                            projectID: complainProject.id,
                                            userID: id,
                                          ));
                                          if(respo.status){
                                            Navigator.pop(context);
                                            Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                          }
                                          else{
                                            Toast.show(msgError, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                          }
                                        }
                                        else{
                                          final respo = await model.AddProjectQuery(Query(
                                            email: email,
                                            description: _bodyController.text,
                                            query: _subjectController.text,
                                            projectID: complainProject.id,
                                            userID: id,
                                          ));
                                          if(respo.status){
                                            Navigator.pop(context);
                                            Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                          }
                                          else{
                                            Toast.show(msgError, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                          }
                                        }

                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                        padding: EdgeInsets.all(0.0),
                                        child:
                                        Ink(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [Color(0xffFF9933), Color(0xff58A451)],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              borderRadius: BorderRadius.circular(10.0)
                                          ),
                                          child: Container(
                                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text('Continue',style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white
                                                ),),
                                                SizedBox(width: 5,),
                                                Icon(Icons.send,color: Colors.white,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),),

                                    ],
                                  ),
                                ),
//                            Container(
//                              width: MediaQuery.of(context).size.width / 2.3,
//                              height: 40,
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.end,
//                                crossAxisAlignment: CrossAxisAlignment.end,
//                                children: [
//                                  Expanded(child: RaisedButton(
//                                    onPressed: (){
//                                      _showPicker(context);
//                                    },
//                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
//                                    padding: EdgeInsets.all(0.0),
//                                    child: Ink(
//                                      decoration: BoxDecoration(
//                                          gradient: LinearGradient(colors: [Color(0xffFF9933), Color(0xff58A451)],
//                                            begin: Alignment.centerLeft,
//                                            end: Alignment.centerRight,
//                                          ),
//                                          borderRadius: BorderRadius.circular(10.0)
//                                      ),
//                                      child: Container(
//                                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
//                                        alignment: Alignment.center,
//                                        child: Row(
//                                          mainAxisAlignment: MainAxisAlignment.center,
//                                          mainAxisSize: MainAxisSize.min,
//                                          children: <Widget>[
//
//                                            Icon(Icons.attach_file,color: Colors.white,),
//                                            SizedBox(width: 5,),
//                                            Text('Attachment',style: TextStyle(
//                                                fontSize: 18,
//                                                color: Colors.white
//                                            ),),
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),),
//
//                                ],
//                              ),
//                            ),
                              ],
                            ),

                          ],
                        ),
                      ),)
                    ],
                  ),
                ),
              )
          ),
          data: Theme.of(context)
              .copyWith(primaryColor: Colors.orange,),
        ),

      )
              ),
          );
        });
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  void _openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        attachments.add(pickedFile.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }
}