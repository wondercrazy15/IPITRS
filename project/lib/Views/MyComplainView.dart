import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:project/ViewModels/MyComplainViewModel.dart';

import 'package:stacked/stacked.dart';

import 'package:intl/intl.dart';

import 'constants.dart';

class MyComplainView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _myComplainView();
  }

}

class _myComplainView extends State<MyComplainView> {

  @override
  Widget build(BuildContext context) {
    return
      ViewModelBuilder<MyComplainViewmodel>.reactive(
        viewModelBuilder: () => MyComplainViewmodel(),
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
                        title: Text("My Complains",style: TextStyle(fontSize: 18)),
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
                    (model.myComplainList.data!=null)?SafeArea(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: new ClampingScrollPhysics(),
                        itemCount: model.myComplainList.data.length,
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
                                        Icon(CupertinoIcons
                                            .person_crop_circle_badge_exclam,
                                          color: Colors.orange,),
                                        SizedBox(width: 10,),
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text((model.myComplainList.data[index].projectName!=null)?
                                                  model.myComplainList.data[index].projectName:"",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                  textAlign: TextAlign.start,
                                                ),
                                                SizedBox(height: 5,),
                                                Text((model.myComplainList.data[index].description!=null)?model.myComplainList.data[index].description:""),

                                                Align(
                                                  heightFactor: 0,
                                                  alignment: Alignment
                                                      .bottomRight,
                                                  child: Text(getDate(model.myComplainList.data[index].createdDate),

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