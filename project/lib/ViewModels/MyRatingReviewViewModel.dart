import 'package:flutter/cupertino.dart';
import 'package:project/Models/RatingReview.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class MyRatingReviewViewModel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
    await GetMyRatingReviewList();
  }
  MyRatingReviewList myRatingReviewList = MyRatingReviewList();
  String Info="";
  Future<void> GetMyRatingReviewList() async {
    setBusy(true);
    final results =  await Webservice().GetMyRatingReviewList();
    myRatingReviewList = results;
    if(myRatingReviewList.data==null){
      Info="No data found";
    }
    notifyListeners();
    setBusy(false);
  }
}