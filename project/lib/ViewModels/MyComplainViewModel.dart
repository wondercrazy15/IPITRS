

import 'package:flutter/cupertino.dart';
import 'package:project/Models/Complain.dart';
import 'package:project/Models/RatingReview.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class MyComplainViewmodel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
    await GetMyComplainList();
  }
  MyComplainList myComplainList = MyComplainList();
  String Info="";
  Future<void> GetMyComplainList() async {
    setBusy(true);
    final results =  await Webservice().GetMyComplainList();
    myComplainList = results;
    if(myComplainList.data==null){
      Info="No data found";
    }
    notifyListeners();
    setBusy(false);
  }
}