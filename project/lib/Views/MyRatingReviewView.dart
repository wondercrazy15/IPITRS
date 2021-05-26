import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:project/ViewModels/MyRatingReviewViewModel.dart';
import 'package:project/Views/ProjectView.dart';
import 'package:stacked/stacked.dart';
import 'constants.dart';

class MyRatingReviewView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _myRatingReviewView();
  }

}

class _myRatingReviewView extends State<MyRatingReviewView> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyRatingReviewViewModel>.reactive(
        viewModelBuilder: () => MyRatingReviewViewModel(),
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
                      title: Text("My RatingReviews",style: TextStyle(fontSize: 18)),
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
                  (model.myRatingReviewList.data!=null)?SafeArea(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: new ClampingScrollPhysics(),
                      itemCount: model.myRatingReviewList.data.length,
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
//                                      Icon(CupertinoIcons.question_circle,color: Colors.orange,),
//                                      SizedBox(width: 10,),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text((model.myRatingReviewList.data[index].projectName!=null)?
                                              model.myRatingReviewList.data[index].projectName:"",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight
                                                        .bold),
                                                textAlign: TextAlign.start,
                                              ),
                                              SizedBox(height: 5,),
                                              Text((model.myRatingReviewList.data[index].review!=null)?model.myRatingReviewList.data[index].review:""),
                                              SizedBox(height: 5,),
                                              Align(
                                                heightFactor: 1,
                                                alignment: Alignment
                                                    .bottomLeft,
                                                child: RatingBar.builder(
                                                  initialRating: double.parse(model.myRatingReviewList.data[index].rating.toString()),
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
                                              Align(
                                                heightFactor: 0,
                                                alignment: Alignment
                                                    .bottomRight,
                                                child: Text(getDate(model.myRatingReviewList.data[index].createdDate),

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