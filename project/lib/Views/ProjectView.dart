import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:project/Models/Banner.dart';
import 'package:project/Models/ProjectInfo.dart' as Project;
import 'package:project/Models/ProjectList.dart';
import 'package:project/Models/RatingReview.dart';
import 'package:project/ViewModels/ProjectViewViewModel.dart';
import 'package:project/blocs/ProjectBloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ComplainView.dart';
import 'DocumentView.dart';
import 'ImageList.dart';
import 'LoginView.dart';
import 'ProjectListView.dart';
import 'constants.dart';

class ProjectView extends StatefulWidget {
  String Code;
  ProjectView(this.Code);

  @override
  State<StatefulWidget> createState() {
    return _projectInfoView(Code);
  }
}
class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _projectInfoView extends State<ProjectView> {
  String Code;
  double givenRating=3;
  _projectInfoView(this.Code);
  _makingPhoneCall(String number) async {
    var url = "tel:"+number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return
     ViewModelBuilder<ProjectViewViewModel>.reactive(
        viewModelBuilder: () => ProjectViewViewModel(),
        onModelReady: (model) async => await model.initModel(context,Code),
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
                appBar: AppBar(
                    centerTitle: true,
                    title: SingleChildScrollView(scrollDirection: Axis.horizontal,
                        child:Text((model.response.data==null)?"Project Detail":model.response.data.name,
                            style: TextStyle(fontSize: 18))
                    ),
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color(0xffff8000),Color(0xff008000)
                              ])
                      ),)
                ),
                body:
                Container(
                    child:
                    ((model.response!=null)?
          ((model.response.data!=null)
                        ?ListView(
                      physics: new ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ImageList(model.response.data.name,model.response.data.projectImageList),
                        Divider(
                          thickness: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                          child: Text(
                            "Project Information",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: Colors.black87),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5,bottom: 5),
                          child: Row(
                            children: [
                              Container(

                                width: MediaQuery.of(context).size.width / 3.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Project Name",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child:
                                  Text(
                                    (model.response.data.name==null)?"":model.response.data.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),

                                  ),

                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Location",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (model.response.data.addressList.first.area==null)?"":model.response.data.addressList.first.area,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.start,
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child:
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: Text("Budget",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text((model.response.data.budget==null)?"":model.response.data.budget.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Start Date",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text((model.response.data.startDate==null)?"":
                                      getDate(model.response.data.startDate),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("End Date",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text((model.response.data.endDate==null)?"":
                                      getDate(model.response.data.endDate),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Status",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text((model.response.data.status==null)?"":
                                      model.response.data.status,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold)
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child:
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: Text("Rating",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                  child:
                                  RatingBar.builder(
                                    initialRating: double.parse(model.response.data.averageRating.toString()),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 25,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => LinearGradientMask(
                                      child: Icon(
                                        Icons.star,
                                        size: 250,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: Text(
                            "Contractor Information",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 0, bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child:SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    (model.response.data.contractorList.first.name==null)?"":model.response.data.contractorList.first.name,
                                    style: TextStyle(fontSize: 16),
                                    maxLines: 1,softWrap: false,),
                                ),

                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text((model.response.data.contractorList.first.phoneNumber==null)?"":
                                      model.response.data.contractorList.first.phoneNumber,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.phone_circle_fill,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    " Call Now",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16  ,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              onTap: () {
                                _makingPhoneCall((model.response.data.contractorList.first.phoneNumber==null)?"":
                                model.response.data.contractorList.first.phoneNumber,);
                              },
                            )
                        ),
                        (model.response.data.projectDocumentList.length>0)?
                        Divider(
                          thickness: 6,
                        ):Container(),
                        (model.response.data.projectDocumentList.length>0)?
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: Text(
                            "Project Document",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ):Container(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: new ClampingScrollPhysics(),
                          itemCount: model.response.data.projectDocumentList.length,
                          itemBuilder: (context, index) {
                            return
                             GestureDetector(
                               child:  Padding(padding: EdgeInsets.all(8),child:  Text(
                                 (model.response.data.projectDocumentList.first.name==null)?"":
                                 model.response.data.projectDocumentList.first.name,
                                 style: TextStyle(
                                   fontSize: 16,
                                   color: Colors.black87,
                                 ),
                                 textAlign: TextAlign.start,
                               ),),

                               onTap: (){
                                  String url=model.response.data.projectDocumentList.first.filePath==null?"":
                                  model.response.data.projectDocumentList.first.filePath;
                                  if(url!=""){
                                      Navigator.push(context,
                                      MaterialPageRoute<dynamic>(
                                      builder: (_) => DocumentView(url: url,),),
                                      );
                                    }
                                  },
                             );
                          },
                          separatorBuilder: (context, index) {
                            return Container(height: 1,color: Colors.black26,);
                          },
                        ),

                        Divider(
                          thickness: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: Text(
                            "Browse Project",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width)/2.3,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>ProjectListView((model.response.data.addressList.first.area==null)
                                                ?"":model.response.data.addressList.first.area,"location")
                                        ));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.orange)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context).size.width,
                                              minHeight: 45.0),
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: [
                                              Text(
                                                "By Location",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16, color: Colors.black87),
                                              ),
                                          Padding(padding: EdgeInsets.only(left: 10,right: 10),
                                            child:
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                              (model.response.data.addressList.first.area==null)?"":model.response.data.addressList.first.area,
                                              style: TextStyle(fontSize: 15),
                                              overflow: TextOverflow.fade,maxLines: 1,softWrap: false,
                                            ),),
                                          ),
                                            ],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width)/2.3,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>ProjectListView((model.response.data.contractorList.first.name==null)?"":model.response.data.contractorList.first.name
                                                ,"contractorName")
                                        ));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.orange)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context).size.width,
                                              minHeight: 45.0),
                                          alignment: Alignment.center,
                                          child:
                                          Column(
                                            children: [
                                              Text(
                                                "By Contractor ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16, color: Colors.black87),
                                              ),
                                              Padding(padding: EdgeInsets.only(left: 10,right: 10),
                                              child:
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                  (model.response.data.contractorList.first.name==null)?"":model.response.data.contractorList.first.name,style: TextStyle(fontSize: 15),
                                                  maxLines: 1,softWrap: false,
                                                ),
                                              ),
                                                  )
                                            ],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width)/2.3,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>ProjectListView((model.response.data.status==null)?"":model.response.data.status,"status")
                                        ));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.orange)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context).size.width,
                                              minHeight: 45.0),
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: [
                                              Text(
                                                "By Status",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16, color: Colors.black87),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                    (model.response.data.status==null)?"":model.response.data.status,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 15, color: Colors.black87,),overflow: TextOverflow.fade
                                                ),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 6,
                        ),
                        (model.response.data.projectReviewList!=null?model.response.data.projectReviewList.length>0:"")?
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                          child: Text(
                            "Review of Project",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ):Container(),
                        (model.response.data.projectReviewList!=null?model.response.data.projectReviewList.length>0:"")?
                        ListView.builder(
                          shrinkWrap: true,
                          physics: new ClampingScrollPhysics(),
                          itemCount: model.response.data.projectReviewList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            // width: MediaQuery.of(context).size.width / 3.2,
                                            child: Text(model.response.data.projectReviewList[index].userName,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
//                                  Expanded(
//                                    child:RatingBar.builder(
//                                      initialRating: reviewList[index].rating,
//                                      minRating: 1,
//                                      direction: Axis.horizontal,
//                                      allowHalfRating: false,
//                                      itemCount: 5,
//                                      itemSize: 20,
//                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                                      itemBuilder: (context, _) => LinearGradientMask(
//                                        child: Icon(
//                                          Icons.star,
//                                          size: 250,
//                                          color: Colors.white,
//                                        ),
//                                      ),
//
//                                    ),
//                                  )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        model.response.data.projectReviewList[index].review,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87,),
                                        textAlign: TextAlign.start,
                                      )
                                    ],
                                  ),
                                )
                            );
                          },
                        ):Container()

                      ],
                    )
                        :Container()):Container())


                ),
                bottomNavigationBar:
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Color(0xffff8000),Color(0xff008000)
                            ])
                    ),
                    padding: EdgeInsets.all(2),
                    child: SafeArea(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          GestureDetector(
                            child: Container( width:  MediaQuery.of(context).size.width / 3.5,height: 40,
                                child:
                                Center(child: Text("Review & Rating ",maxLines: 2,style: TextStyle(fontSize: 16,color: Colors.white,
                                    fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),),
                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var isLogin = prefs.getBool("IsLogin");
                              if(isLogin == null)
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        LoginView()
                                ));
                              }
                              else{
                              _showRatingBar(context,model);
                            }
                            }
                          ),
                          Container(height: 25, child: VerticalDivider(color: Colors.white,thickness: 2,)),

                          GestureDetector(
                            child: Container( width:  MediaQuery.of(context).size.width / 3.5,height: 25,
                              child: Center(child: Text("Complain",style: TextStyle(fontSize: 16,color: Colors.white,
                                  fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),),

                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var isLogin = prefs.getBool("IsLogin");
                              if(isLogin == null)
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        LoginView()
                                ));
                              }else{
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        ComplainView(model.response.data, true)
                                ));
                              }
                            },
                          ),
                          Container(height: 25, child: VerticalDivider(color: Colors.white,thickness: 2,)),
                          GestureDetector(
                            child:Container( width:  MediaQuery.of(context).size.width / 3.5,height: 25,
                              child: Center(child: Text("Query",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),),

                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var isLogin = prefs.getBool("IsLogin");
                              if(isLogin == null)
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        LoginView()
                                ));
                              }
                              else{
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>ComplainView(model.response.data,false)
                              ));
                              }
                              //send(model);
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute<dynamic>(
//                            builder: (_) => DocumentView(
//                          url: 'http://suratmunicipalcorporation.org:8020/BridgeCell/CreekBridge/CB_1.pdf',
//                        ),
//                        ),
//                        );
                            },
                          ),

                        ],
                      ),
                    )

                ),
              )
            ),
          );
        });

  }
//  Future<void> send(ProjectViewViewModel model) async {
//    final Email email = Email(
//      body: "Project Name: "+model.response.data.name+"\n\n"+"Location: "+model.response.data.addressList.first.area+"\n",
//      subject: "Query about project",
//      recipients: [model.response.data.contractorList.first.email],
//      attachmentPaths: null,
//      isHTML: false,
//    );
//
//    String platformResponse;
//
//    try {
//      await FlutterEmailSender.send(email);
//
//    } catch (error) {
//      platformResponse = "Gmail account not found";
//    }
//
//  }

  final _formKey = GlobalKey<FormState>();
  String review ="";
  String UserId="";
  void _showRatingBar(context, ProjectViewViewModel model) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SafeArea(
              child:
              SingleChildScrollView(
                  child:
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text(
                            "Give your Review and Rating to this Project",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),

                          Theme(
                            child: TextFormField(
                              autofocus: true,
                              onSaved: (newValue) => review = newValue,
                              decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintText: "Enter Your Review",
                                  labelText: "Review"

                              ),
                              keyboardType: TextInputType.multiline,
                              maxLength: null,
                              maxLines: 5,
                              cursorColor: Colors.orange,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Please Write Review";
                                }
                                else if(value.length<10){
                                  return "Please enter Review more then 10 character";
                                }

                              },
                            ),
                            data: Theme.of(context)
                                .copyWith(primaryColor: Colors.orange,),

                          ),
                          SizedBox(height: 10),
                          RatingBar.builder(
                            initialRating: givenRating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => LinearGradientMask(
                              child: Icon(
                                Icons.star,
                                size: 250,
                                color: Colors.white,
                              ),
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                givenRating=rating;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width-200,
                              child: RaisedButton(
                                onPressed: () async{
                                  if(_formKey.currentState.validate())
                                  {
                                    _formKey.currentState.save();
                                    bool connected = await IsConnected();
                                    if(!connected){
                                      Toast.show(msgNoInternet, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                      return;
                                    }
                                    print(review);
                                    print(givenRating);
                                    Navigator.pop(context);
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    if(prefs.getString("UserId")!=null)
                                      UserId = prefs.getString("UserId");
                                    final respo = await model.AddProjectReview(RatingReview(
                                      review: review,
                                      rating: givenRating,
                                      projectID: model.response.data.id,
                                      userID: UserId,
                                    ));
                                    if(respo.status){
                                      Toast.show(respo.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    }
                                    else{
                                      Toast.show(msgError, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(

                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [Color(0xffFF9933), Color(0xff58A451)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),

                                  child:
                                  Container(
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Submit",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                          ),
                        ],
                      ),
                    ),
                  )
              )

          );
        }
    );
  }
  String getDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}
class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffff8000),Color(0xff6BBF64)],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

