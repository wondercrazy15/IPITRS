import 'package:flutter/cupertino.dart';
import 'package:project/Models/Query.dart';
import 'package:project/Services/Webservice.dart';
import 'package:stacked/stacked.dart';

class MyQueryViewmodel extends BaseViewModel {

  void initModel(BuildContext context) async{
    Webservice().initContext(context);
    await GetMyQueryList();
  }
  MyQueryList myQueryList = MyQueryList();
  String Info="";
  Future<void> GetMyQueryList() async {
    setBusy(true);
    final results =  await Webservice().GetMyQueryList();
    myQueryList = results;
    if(myQueryList.data==null){
      Info="No data found";
    }
    notifyListeners();
    setBusy(false);
  }
}