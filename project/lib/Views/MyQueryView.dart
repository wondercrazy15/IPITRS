import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Banner.dart';
import 'package:project/ViewModels/MyQueryViewmodel.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'constants.dart';

class MyQueryView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _myQueryView();
  }

}

class _myQueryView extends State<MyQueryView> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyQueryViewmodel>.reactive(
        viewModelBuilder: () => MyQueryViewmodel(),
        onModelReady: (model) async => await model.initModel(context),
        builder: (context, model, child) {
          return KeyboardDismisser(
            gestures: [
              GestureType.onTap,
              GestureType.onPanUpdateDownDirection,
            ],
            child: ModalProgressHUD(
                opacity: 0.5,
                inAsyncCall: model.isBusy,
                progressIndicator: getLoader(),
                color: Colors.white,
                child:
                Scaffold(
                  appBar: AppBar(
                      centerTitle: true,
                      title: Text("My Query",style: TextStyle(fontSize: 18)),
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Color(0xffff8000), Color(0xff008000)
                                ])
                        ),)
                  ),
                  body:
                  (model.myQueryList.data!=null)?SafeArea(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: new ClampingScrollPhysics(),
                      itemCount: model.myQueryList.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Icon(CupertinoIcons.question_circle,color: Colors.orange,),
                                      SizedBox(width: 10,),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text((model.myQueryList.data[index].projectName!=null)?
                                              model.myQueryList.data[index].projectName:"",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight
                                                        .bold),
                                                textAlign: TextAlign.start,
                                              ),
                                              SizedBox(height: 5,),
                                              Text((model.myQueryList.data[index].description!=null)?model.myQueryList.data[index].description:""),

                                              Align(
                                                heightFactor: 0,
                                                alignment: Alignment
                                                    .bottomRight,
                                                child: Text(getDate(model.myQueryList.data[index].createdDate),

                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold),
                                                  textAlign: TextAlign.end,),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),

                                ],
                              )
                          ),

                        );
                      },
                    ),
                  )
                  :Container(child: Center(child:
                  Text(model.Info),
                  ),),

                )),
          );
        });

  }
  String getDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(dateTime);
    return formatted;

  }

}